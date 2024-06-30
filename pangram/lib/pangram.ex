defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @alphabet ?a..?z

  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
    freq =
      sentence
      |> String.downcase()
      |> String.codepoints()
      |> Enum.frequencies()

    @alphabet |> Enum.all?(fn letter -> Map.has_key?(freq, <<letter>>) end)
  end
end
