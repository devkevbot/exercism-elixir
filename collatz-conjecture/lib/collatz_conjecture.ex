defmodule CollatzConjecture do
  require Integer

  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input) when is_integer(input) and input > 0 do
    do_calc(input)
  end

  defp do_calc(input, steps \\ 0) do
    cond do
      input == 1 -> steps
      Integer.is_even(input) -> do_calc(div(input, 2), steps + 1)
      true -> do_calc(3 * input + 1, steps + 1)
    end
  end
end
