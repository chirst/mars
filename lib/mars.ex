defmodule Mars do
  @moduledoc """
  Mars is responsible for orchestrating Readers and Rovers.
  """

  def execute_mission do
    for r <- Reader.rovers_from_file("test.txt"), do: r |> Rover.navigate
    # TODO introduce writer
  end
end
