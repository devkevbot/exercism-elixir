defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  @spec compare(list(), list()) :: :equal | :sublist | :superlist | :unequal
  def compare(a, b) do
    cond do
      equal?(a, b) -> :equal
      sublist?(a, b) -> :superlist
      sublist?(b, a) -> :sublist
      true -> :unequal
    end
  end

  defp equal?(a, b), do: a === b

  defp sublist?(a, b) when length(a) < length(b), do: false

  defp sublist?(a, b) do
    equal?(Enum.take(a, length(b)), b) or sublist?(tl(a), b)
  end
end
