defmodule Rover.Writer do
  @moduledoc """
  Writer is responsible for writing valid rovers to external sources. For
  example a file or console.
  """

  @doc """
  Writes a line for each rover to a text file at the given path. Each line
  describes the rovers position and heading.
  """
  @spec file(String.t(), [Rover]) :: :ok | :error
  def file(path, rovers) do
    content = Enum.map_join(rovers, "\n", &line(&1))
    File.write(path, content)
  end

  @spec line(%Rover{}) :: String.t()
  def line(%Rover{x: x, y: y, heading: heading}) do
    ~s(#{x} #{y} #{to_heading(heading)})
  end

  defp to_heading(heading) do
    case heading do
      :north -> "N"
      :east -> "E"
      :south -> "S"
      :west -> "W"
    end
  end
end
