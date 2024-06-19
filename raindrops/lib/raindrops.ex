defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    res = []
    res = if rem(number, 3) == 0, do: ["Pling" | res], else: res
    res = if rem(number, 5) == 0, do: ["Plang" | res], else: res
    res = if rem(number, 7) == 0, do: ["Plong" | res], else: res

    if Enum.empty?(res), do: Integer.to_string(number), else: Enum.join(Enum.reverse(res))
  end
end
