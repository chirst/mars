defmodule Reader do
  @moduledoc """
  Reader is responsible for creating rovers from external sources. For example a
  file or console input.
  """

  @spec rovers_from_file(String.t()) :: list(Rover)
  def rovers_from_file(path) do
    {:ok, binary} = File.read(path)
    [first_line | lines] = String.split(binary, "\n", trim: true)
    [max_x, max_y] = parse_dimension(first_line)

    lines
    |> Enum.chunk_every(2)
    |> Enum.map(&parse_rover(&1, max_x, max_y))
  end

  defp parse_dimension(dimension_line) do
    for d <- String.split(dimension_line, " "), do: String.to_integer(d)
  end

  defp parse_rover(rover, max_x, max_y) do
    [position, commands] = rover
    [x, y, heading] = String.split(position, " ", trim: true)

    %Rover{
      x: String.to_integer(x),
      y: String.to_integer(y),
      heading: parse_heading(heading),
      commands:
        for(c <- String.split(commands, "", trim: true), do: parse_command(c)),
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

  defp parse_command(command) do
    case command do
      "L" -> :left
      "R" -> :right
      "M" -> :forward
      _ -> raise "invalid command"
    end
  end
end
