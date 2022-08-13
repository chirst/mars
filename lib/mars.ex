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
        %Rover{rover | x: get_forward_x(rover), y: get_forward_y(rover), commands: commands}

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

  defp get_forward_x(rover) do
    case rover.heading do
      :north -> rover.x
      :south -> rover.x
      :east -> rover.x + 1
      :west -> rover.x - 1
    end
  end

  defp get_forward_y(rover) do
    case rover.heading do
      :north -> rover.y + 1
      :south -> rover.y - 1
      :east -> rover.y
      :west -> rover.y
    end
  end
end
