defmodule LogLevel do
  def to_label(level, legacy?) do
    cond do
      legacy? and level in [0, 5] -> :unknown
      level == 0 -> :trace
      level == 1 -> :debug
      level == 2 -> :info
      level == 3 -> :warning
      level == 4 -> :error
      level == 5 -> :fatal
      true -> :unknown
    end
  end

  def alert_recipient(level, legacy?) do
    label = to_label(level, legacy?)

    cond do
      legacy? and label == :unknown -> :dev1
      label == :unknown -> :dev2
      label in [:error, :fatal] -> :ops
      true -> false
    end
  end
end
