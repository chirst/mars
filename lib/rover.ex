defmodule Rover do
  @moduledoc """
  Rover defines how to create and command a single rover.
  """

  @enforce_keys [:x, :y, :heading, :commands, :max_x, :max_y]
  defstruct @enforce_keys

  def navigate(%Rover{commands: commands} = rover) when length(commands) > 0 do
    rover |> command |> navigate
  end

  def navigate(rover) do rover end

  def command(%Rover{commands: commands} = rover) when length(commands) > 0 do
    [command | commands] = rover.commands

    case command do
      :left ->
        %Rover{rover | heading: rover |> Rover.left, commands: commands}

      :right ->
        %Rover{rover | heading: rover |> Rover.right, commands: commands}

      :forward ->
        [x, y] = rover |> Rover.forward

        %Rover{
          rover
          | x: x,
            y: y,
            commands: commands
        }
    end
  end

  def command(rover) do rover end

  def left(%{heading: heading}) do
    case heading do
      :north -> :west
      :west -> :south
      :south -> :east
      :east -> :north
      _ -> raise "invalid heading"
    end
  end

  def right(%{heading: heading}) do
    case heading do
      :north -> :east
      :east -> :south
      :south -> :west
      :west -> :north
      _ -> raise "invalid heading"
    end
  end

  def forward(%{heading: heading, x: x, y: y, max_x: max_x, max_y: max_y}) do
    case heading do
      :north when y == max_y -> [x, 0]
      :north -> [x, y + 1]
      :south when y == 0 -> [x, max_y]
      :south -> [x, y - 1]
      :east when x == max_x -> [0, y]
      :east -> [x + 1, y]
      :west when x == 0 -> [max_x, y]
      :west -> [x - 1, y]
      _ -> raise "unhandled forward"
    end
  end
end
