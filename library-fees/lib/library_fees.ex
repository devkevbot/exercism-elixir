defmodule LibraryFees do
  @spec datetime_from_string(binary()) :: NaiveDateTime.t()
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  @spec before_noon?(NaiveDateTime.t()) :: boolean()
  def before_noon?(datetime) do
    datetime.hour < 12
  end

  @days_to_return_before_noon 28
  @days_to_return_after_noon 29

  @monday 1

  @spec return_date(NaiveDateTime.t()) :: Date.t()
  def return_date(checkout_datetime) do
    if before_noon?(checkout_datetime) do
      Date.add(NaiveDateTime.to_date(checkout_datetime), @days_to_return_before_noon)
    else
      Date.add(NaiveDateTime.to_date(checkout_datetime), @days_to_return_after_noon)
    end
  end

  @spec days_late(Date.t(), NaiveDateTime.t()) :: non_neg_integer()
  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_datetime |> NaiveDateTime.to_date() |> Date.diff(planned_return_date) |> max(0)
  end

  @spec monday?(NaiveDateTime.t()) :: boolean()
  def monday?(datetime) do
    datetime |> NaiveDateTime.to_date() |> Date.day_of_week() == @monday
  end

  @spec calculate_late_fee(binary(), binary(), non_neg_integer()) :: non_neg_integer()
  def calculate_late_fee(checkout, actual_return, rate) do
    planned_return_date = checkout |> datetime_from_string() |> return_date()
    actual_return_datetime = datetime_from_string(actual_return)

    num_days_late = days_late(planned_return_date, actual_return_datetime)

    rate = if monday?(actual_return_datetime), do: rate * 0.5, else: rate
    floor(rate * num_days_late)
  end
end
