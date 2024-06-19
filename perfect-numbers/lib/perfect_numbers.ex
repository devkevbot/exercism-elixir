defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) when number <= 0,
    do: {:error, "Classification is only possible for natural numbers."}

  def classify(number) do
    sum =
      1..number
      |> Enum.filter(fn num -> num != number and rem(number, num) == 0 end)
      |> Enum.sum()

    cond do
      sum < number -> {:ok, :deficient}
      sum > number -> {:ok, :abundant}
      true -> {:ok, :perfect}
    end
  end
end
