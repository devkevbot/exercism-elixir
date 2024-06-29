defmodule Proverb do
  @doc """
  Generate a proverb from a list of strings.
  """
  @spec recite(strings :: [String.t()]) :: String.t()
  def recite([]), do: ""
  def recite([string]), do: "And all for the want of a #{string}.\n"

  def recite(strings) do
    lines =
      strings
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.map(fn [first, second] -> "For want of a #{first} the #{second} was lost." end)

    lines = lines ++ ["And all for the want of a #{hd(strings)}.\n"]
    Enum.join(lines, "\n")
  end
end
