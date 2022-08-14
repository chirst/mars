defmodule Mars do
  defmodule Rover do
    @enforce_keys [:x, :y, :heading, :commands, :max_x, :max_y]
    defstruct @enforce_keys
  end

  @spec navigate(Rover) :: Rover
  def navigate(rover) do
    do_commands(rover, rover.commands)
  end

  defp do_commands(rover, commands) when length(commands) > 0 do
    r = apply_command(rover)
    do_commands(r, r.commands)
  end

  defp do_commands(rover, _commands) do
    rover
  end

  defp apply_command(rover) do
    [command | commands] = rover.commands

    case command do
      :left ->
        %Rover{rover | heading: get_left(rover.heading), commands: commands}

      :right ->
        %Rover{rover | heading: get_right(rover.heading), commands: commands}

      :forward ->
        [x, y] = get_forward(rover)

        %Rover{
          rover
          | x: x,
            y: y,
            commands: commands
        }

      _ ->
        raise "invalid command"
    end
  end

  defp get_left(heading) do
    case heading do
      :north -> :west
      :west -> :south
      :south -> :east
      :east -> :north
      _ -> raise "invalid heading"
    end
  end

  defp get_right(heading) do
    case heading do
      :north -> :east
      :east -> :south
      :south -> :west
      :west -> :north
      _ -> raise "invalid heading"
    end
  end

  defp get_forward(%{heading: heading, x: x, y: y, max_x: max_x, max_y: max_y}) do
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
