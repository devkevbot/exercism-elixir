defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    @message "stack underflow occurred"
    defexception message: @message

    @impl true
    def exception(value) do
      case value do
        [] -> %StackUnderflowError{}
        _ -> %StackUnderflowError{message: "#{@message}, context: " <> value}
      end
    end
  end

  def divide(stack) when length(stack) < 2 do
    raise StackUnderflowError, "when dividing"
  end

  def divide([divisor, _]) when divisor === 0 do
    raise DivisionByZeroError
  end

  def divide([divisor, dividend]), do: dividend / divisor
end
