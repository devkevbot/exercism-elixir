defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    Enum.filter(candidates, fn candidate ->
      anagram?(String.downcase(base), String.downcase(candidate))
    end)
  end

  defp anagram?(base, base), do: false

  defp anagram?(base, candidate) do
    letter_freq(base) == letter_freq(candidate)
  end

  defp letter_freq(word) do
    word |> String.graphemes() |> Enum.frequencies()
  end
end
