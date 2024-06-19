defmodule Yacht do
  @type category ::
          :ones
          | :twos
          | :threes
          | :fours
          | :fives
          | :sixes
          | :full_house
          | :four_of_a_kind
          | :little_straight
          | :big_straight
          | :choice
          | :yacht

  @doc """
  Calculate the score of 5 dice using the given category's scoring method.
  """
  @spec score(category :: category(), dice :: [integer]) :: integer
  def score(category, dice), do: dice |> Enum.sort() |> calc_score(category)

  defp calc_score(dice, :ones), do: sum(dice, 1)
  defp calc_score(dice, :twos), do: sum(dice, 2)
  defp calc_score(dice, :threes), do: sum(dice, 3)
  defp calc_score(dice, :fours), do: sum(dice, 4)
  defp calc_score(dice, :fives), do: sum(dice, 5)
  defp calc_score(dice, :sixes), do: sum(dice, 6)
  defp calc_score([a, a, a, a, a], :full_house), do: 0
  defp calc_score([a, a, a, b, b], :full_house), do: a * 3 + b * 2
  defp calc_score([a, a, b, b, b], :full_house), do: a * 2 + b * 3
  defp calc_score(_, :full_house), do: 0
  defp calc_score(dice, :choice), do: Enum.sum(dice)
  defp calc_score([a, a, a, a, a], :yacht), do: 50
  defp calc_score(_, :yacht), do: 0
  defp calc_score([a, a, a, a, _], :four_of_a_kind), do: a * 4
  defp calc_score([_, b, b, b, b], :four_of_a_kind), do: b * 4
  defp calc_score(_, :four_of_a_kind), do: 0
  defp calc_score([1, 2, 3, 4, 5], :little_straight), do: 30
  defp calc_score(_, :little_straight), do: 0
  defp calc_score([2, 3, 4, 5, 6], :big_straight), do: 30
  defp calc_score(_, :big_straight), do: 0

  defp sum(dice, num) do
    dice |> Enum.filter(&(&1 === num)) |> Enum.sum()
  end
end
