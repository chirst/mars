defmodule Mars do
  @moduledoc """
  Mars is responsible for orchestrating Readers and Rovers.
  """

  def execute_mission do
    for r <- Rover.Reader.file("test.txt"), do: Rover.navigate(r)
    # TODO introduce writer
  end
end
