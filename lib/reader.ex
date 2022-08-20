defmodule Rover.Reader do
  @moduledoc """
  Reader is responsible for creating rovers from external sources. For example a
  file or console input.
  """

  @doc """
  Expects to read a text file as described in the README at the given path and
  returns a list of rovers.
  """
  @spec file(String.t()) :: [Rover]
  def file(path) do
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

  defp parse_rover([position, commands], max_x, max_y) do
    [x, y, heading] = String.split(position, " ", trim: true)

    Rover.new(
      String.to_integer(x),
      String.to_integer(y),
      parse_heading(heading),
      for(c <- String.split(commands, "", trim: true), do: parse_command(c)),
      max_x,
      max_y
    )
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
