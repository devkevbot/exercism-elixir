defmodule FreelancerRates do
  def daily_rate(hourly_rate) do
    8.0 * hourly_rate
  end

  def apply_discount(before_discount, discount) do
    before_discount * (1 - discount / 100.0)
  end

  def monthly_rate(hourly_rate, discount) do
    before_discount = 22.0 * daily_rate(hourly_rate)
    apply_discount(before_discount, discount) |> Float.ceil() |> Kernel.trunc()
  end

  def days_in_budget(budget, hourly_rate, discount) do
    discounted_rate = apply_discount(daily_rate(hourly_rate), discount)
    num_days = budget / discounted_rate
    Float.floor(num_days, 1)
  end
end
