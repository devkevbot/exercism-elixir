defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    digits = Integer.digits(number)
    size = length(digits)
    number == Enum.reduce(digits, 0, fn digit, sum -> sum + Integer.pow(digit, size) end)
  end
end
