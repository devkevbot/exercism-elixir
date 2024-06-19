defmodule TakeANumber do
  def start() do
    spawn(fn -> listen(0) end)
  end

  defp listen(num) do
    receive do
      {:report_state, sender_pid} ->
        send(sender_pid, num)
        listen(num)

      {:take_a_number, sender_pid} ->
        send(sender_pid, num + 1)
        listen(num + 1)

      :stop ->
        nil

      _ ->
        listen(num)
    end
  end
end
