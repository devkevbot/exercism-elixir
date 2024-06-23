defmodule SecretHandshake do
  import Bitwise

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    actions = []

    actions = if band(code, 1) == 1, do: actions ++ ["wink"], else: actions

    actions =
      if band(bsr(code, 1), 1) == 1,
        do: actions ++ ["double blink"],
        else: actions

    actions =
      if band(bsr(code, 2), 1) == 1,
        do: actions ++ ["close your eyes"],
        else: actions

    actions =
      if band(bsr(code, 3), 1) == 1, do: actions ++ ["jump"], else: actions

    actions =
      if band(bsr(code, 4), 1) == 1, do: Enum.reverse(actions), else: actions

    actions
  end
end
