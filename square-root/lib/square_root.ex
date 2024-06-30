defmodule SquareRoot do
  @doc """
  Calculate the integer square root of a positive integer
  """
  @spec calculate(radicand :: pos_integer) :: pos_integer
  def calculate(radicand) do
    helper(1, radicand)
  end

  @spec helper(curr :: pos_integer, radicand :: pos_integer) :: pos_integer
  defp helper(curr, radicand) when curr * curr === radicand, do: curr

  defp helper(curr, radicand), do: helper(curr + 1, radicand)
end
