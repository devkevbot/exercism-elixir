defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    result = String.trim(input)

    is_question = String.ends_with?(result, "?")
    is_yelling = String.match?(result, ~r/[A-ZА-Я]+/u) and String.upcase(result) == result

    cond do
      is_question and is_yelling -> "Calm down, I know what I'm doing!"
      is_question -> "Sure."
      is_yelling -> "Whoa, chill out!"
      String.length(result) == 0 -> "Fine. Be that way!"
      true -> "Whatever."
    end
  end
end
