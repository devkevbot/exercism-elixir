defmodule LogParser do
  def valid_line?(line) do
    line =~ ~r/^\[(DEBUG|INFO|WARNING|ERROR)\]/
  end

  def split_line(line) do
    line |> String.split(~r/<[~\*=-]*>/)
  end

  def remove_artifacts(line) do
    line |> String.replace(~r/(end-of-line\d+)/i, "")
  end

  def tag_with_user_name(line) do
    result = Regex.run(~r/User\s+(\S+)/u, line)

    if result != nil do
      [_, username] = result
      "[USER] #{username} " <> line
    else
      line
    end
  end
end
