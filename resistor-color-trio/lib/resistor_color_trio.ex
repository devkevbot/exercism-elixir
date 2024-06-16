defmodule ResistorColorTrio do
  @color_code %{
    black: 0,
    brown: 1,
    red: 2,
    orange: 3,
    yellow: 4,
    green: 5,
    blue: 6,
    violet: 7,
    grey: 8,
    white: 9
  }

  @doc """
  Calculate the resistance value in ohms from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label([first_color, second_color, third_color | _]) do
    resistance =
      (@color_code[first_color] * 10 +
         @color_code[second_color]) * :math.pow(10, @color_code[third_color])

    cond do
      resistance < 1_000 -> {resistance, :ohms}
      resistance < 1_000_000 -> {resistance / 1_000, :kiloohms}
      resistance < 1_000_000_000 -> {resistance / 1_000_000, :megaohms}
      true -> {resistance / 1_000_000_000, :gigaohms}
    end
  end
end
