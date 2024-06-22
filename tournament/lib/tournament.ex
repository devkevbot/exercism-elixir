defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    rows =
      Enum.map(input, fn line -> String.split(line, ";") end)
      |> Enum.filter(fn parsed -> length(parsed) == 3 end)
      |> Enum.reduce(Map.new(), fn element, acc -> update_standings(acc, element) end)
      |> Enum.sort_by(fn {team, [wins, _, draws]} -> {-calculate_points(wins, draws), team} end)
      |> Enum.map(fn {team, [wins, losses, draws]} ->
        format_table_row(
          team,
          Integer.to_string(wins + losses + draws),
          Integer.to_string(wins),
          Integer.to_string(draws),
          Integer.to_string(losses),
          Integer.to_string(calculate_points(wins, draws))
        )
      end)

    header = format_table_row("Team", "MP", "W", "D", "L", "P")
    Enum.join([header | rows], "\n")
  end

  defp calculate_points(wins, draws), do: wins * 3 + draws * 1

  defp format_table_row(team, matches_played, wins, draws, losses, points) do
    "#{String.pad_trailing(team, 30)} | #{String.pad_leading(matches_played, 2)} | #{String.pad_leading(wins, 2)} | #{String.pad_leading(draws, 2)} | #{String.pad_leading(losses, 2)} | #{String.pad_leading(points, 2)}"
  end

  defp update_standings(standings, [first, second, "win"]) do
    standings
    |> Map.update(first, [1, 0, 0], fn [w, l, d] -> [w + 1, l, d] end)
    |> Map.update(second, [0, 1, 0], fn [w, l, d] -> [w, l + 1, d] end)
  end

  defp update_standings(standings, [first, second, "loss"]) do
    standings
    |> Map.update(first, [0, 1, 0], fn [w, l, d] -> [w, l + 1, d] end)
    |> Map.update(second, [1, 0, 0], fn [w, l, d] -> [w + 1, l, d] end)
  end

  defp update_standings(standings, [first, second, "draw"]) do
    standings
    |> Map.update(first, [0, 0, 1], fn [w, l, d] -> [w, l, d + 1] end)
    |> Map.update(second, [0, 0, 1], fn [w, l, d] -> [w, l, d + 1] end)
  end

  defp update_standings(standings, [_, _, _]), do: standings
end
