defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(_, size) when size < 1, do: []

  def slices(s, size) do
    if String.length(s) < size do
      []
    else
      0..(String.length(s) - size)
      |> Enum.map(fn i -> String.slice(s, i..(i + size - 1)) end)
      |> Enum.into([])
    end
  end
end
