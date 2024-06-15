defmodule Lasagna do
  def expected_minutes_in_oven do
    40
  end

  def remaining_minutes_in_oven(actual_minutes_in_oven) do
    expected_minutes_in_oven() - actual_minutes_in_oven
  end

  def preparation_time_in_minutes(num_layers) do
    2 * num_layers
  end

  def total_time_in_minutes(num_layers, actual_minutes_in_oven) do
    actual_minutes_in_oven + preparation_time_in_minutes(num_layers)
  end

  def alarm do
    "Ding!"
  end
end
