defmodule Transpose do
  @doc """
  Given an input text, output it transposed.

  Rows become columns and columns become rows. See https://en.wikipedia.org/wiki/Transpose.

  If the input has rows of different lengths, this is to be solved as follows:
    * Pad to the left with spaces.
    * Don't pad to the right.

  ## Examples

    iex> Transpose.transpose("ABC\\nDE")
    "AD\\nBE\\nC"

    iex> Transpose.transpose("AB\\nDEF")
    "AD\\nBE\\n F"
  """

  @spec transpose(String.t()) :: String.t()
  def transpose(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.codepoints/1)
    |> List.foldr([], &combine/2)
    |> Enum.join("\n")
  end

  defp combine([], []), do: []
  defp combine([], [head | tail]), do: [" " <> head | combine([], tail)]
  defp combine([head | tail], []), do: [head | combine(tail, [])]
  defp combine([head1 | tail1], [head2 | tail2]), do: [head1 <> head2 | combine(tail1, tail2)]
end
