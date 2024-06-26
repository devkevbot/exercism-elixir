defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

    iex> RnaTranscription.to_rna(~c"ACTG")
    ~c"UGAC"
  """
  @conversion %{
    ?G => ?C,
    ?C => ?G,
    ?T => ?A,
    ?A => ?U
  }

  @spec to_rna([char]) :: [char]
  def to_rna([]), do: []
  def to_rna([head | tail]), do: [@conversion[head] | to_rna(tail)]
end
