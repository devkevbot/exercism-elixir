defmodule RobotSimulator do
  @type robot() :: {position(), direction()}
  @type direction() :: :north | :east | :south | :west
  @type position() :: {integer(), integer()}

  defstruct [:direction, :position]

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction, position) :: robot() | {:error, String.t()}
  def create(direction \\ :north, position \\ {0, 0})

  def create(_, position) when not is_tuple(position) or tuple_size(position) != 2,
    do: {:error, "invalid position"}

  def create(_, {x, y}) when not (is_integer(x) and is_integer(y)),
    do: {:error, "invalid position"}

  def create(:north, {x, y}) do
    %RobotSimulator{direction: :north, position: {x, y}}
  end

  def create(:east, {x, y}) do
    %RobotSimulator{direction: :east, position: {x, y}}
  end

  def create(:west, {x, y}) do
    %RobotSimulator{direction: :west, position: {x, y}}
  end

  def create(:south, {x, y}) do
    %RobotSimulator{direction: :south, position: {x, y}}
  end

  def create(_, {_x, _y}), do: {:error, "invalid direction"}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot, instructions :: String.t()) :: robot() | {:error, String.t()}
  def simulate(robot, instructions) do
    commands = String.codepoints(instructions)

    result =
      Enum.reduce_while(commands, robot, fn command, acc ->
        case process_command(acc, command) do
          {:error, error} -> {:halt, {:error, error}}
          new_acc -> {:cont, new_acc}
        end
      end)

    result
  end

  defp process_command(robot, "R") do
    new_direction =
      case robot.direction do
        :north -> :east
        :east -> :south
        :south -> :west
        :west -> :north
      end

    %RobotSimulator{robot | direction: new_direction}
  end

  defp process_command(robot, "L") do
    new_direction =
      case robot.direction do
        :north -> :west
        :west -> :south
        :south -> :east
        :east -> :north
      end

    %RobotSimulator{robot | direction: new_direction}
  end

  defp process_command(robot, "A") do
    {curr_x, curr_y} = robot.position

    new_position =
      case robot.direction do
        :north -> {curr_x, curr_y + 1}
        :west -> {curr_x - 1, curr_y}
        :south -> {curr_x, curr_y - 1}
        :east -> {curr_x + 1, curr_y}
      end

    %RobotSimulator{robot | position: new_position}
  end

  defp process_command(_, _), do: {:error, "invalid instruction"}

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot) :: direction()
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot) :: position()
  def position(robot) do
    robot.position
  end
end
