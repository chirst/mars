defmodule Mars do
  defmodule Rover do
    @enforce_keys [:x, :y, :heading, :commands, :max_x, :max_y]
    defstruct @enforce_keys
  end

  def new_rover do
    # load from file
    upper_right_x = 5
    upper_right_y = 5
    rover_x = 1
    rover_y = 2
    rover_heading = "N"
    rover_commands = "LMLMLMLMM"

    %Rover{
      x: rover_x,
      y: rover_y,
      heading: parse_heading(rover_heading),
      commands: parse_commands(rover_commands),
      max_x: upper_right_x,
      max_y: upper_right_y
    }
  end

  def parse_heading(heading) do
    case heading do
      "N" -> :north
      "S" -> :south
      "E" -> :east
      "W" -> :west
      _ -> raise "invalid heading"
    end
  end

  def parse_commands(commands) do
    for c <- String.split(commands, ""), c != "", do: parse_command(c)
  end

  def parse_command(command) do
    case command do
      "L" -> :left
      "R" -> :right
      "M" -> :forward
      _ -> raise "invalid command"
    end
  end

  def navigate(rover) do
    do_commands(rover, rover.commands)
  end

  def do_commands(rover, commands) when length(commands) > 0 do
    r = apply_command(rover)
    do_commands(r, r.commands)
  end

  def do_commands(rover, _commands) do
    rover
  end

  def apply_command(rover) do
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

  def get_left(heading) do
    case heading do
      :north -> :west
      :west -> :south
      :south -> :east
      :east -> :north
      _ -> raise "invalid heading"
    end
  end

  def get_right(heading) do
    case heading do
      :north -> :east
      :east -> :south
      :south -> :west
      :west -> :north
      _ -> raise "invalid heading"
    end
  end

  def get_forward_x(rover) do
    case rover.heading do
      :north -> rover.x
      :south -> rover.x
      :east -> rover.x + 1
      :west -> rover.x - 1
    end
  end

  def get_forward_y(rover) do
    case rover.heading do
      :north -> rover.y + 1
      :south -> rover.y - 1
      :east -> rover.y
      :west -> rover.y
    end
  end
end
