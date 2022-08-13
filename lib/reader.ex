defmodule Reader do
  @spec rovers_from_file(String.t()) :: list(Mars.Rover)
  def rovers_from_file(path) do
    {:ok, binary} = File.read(path)
    [first_line | lines] = String.split(binary, "\n", trim: true)
    [max_x, max_y] = parse_dimensions(first_line)
    parse_rovers(lines, max_x, max_y)
  end

  defp parse_dimensions(dimension_line) do
    for d <- String.split(dimension_line, " "), do: String.to_integer(d)
  end

  defp parse_rovers(rover_lines, max_x, max_y) do
    rovers = Enum.chunk_every(rover_lines, 2)
    for r <- rovers, do: parse_rover(r, max_x, max_y)
  end

  defp parse_rover(rover, max_x, max_y) do
    [position, commands] = rover
    [x, y, heading] = String.split(position, " ", trim: true)

    %Mars.Rover{
      x: String.to_integer(x),
      y: String.to_integer(y),
      heading: parse_heading(heading),
      commands: parse_commands(commands),
      max_x: max_x,
      max_y: max_y
    }
  end

  defp parse_heading(heading) do
    case heading do
      "N" -> :north
      "S" -> :south
      "E" -> :east
      "W" -> :west
      _ -> raise "invalid heading"
    end
  end

  defp parse_commands(commands) do
    for c <- String.split(commands, ""), c != "", do: parse_command(c)
  end

  defp parse_command(command) do
    case command do
      "L" -> :left
      "R" -> :right
      "M" -> :forward
      _ -> raise "invalid command"
    end
  end
end