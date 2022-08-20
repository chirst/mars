defmodule Mars do
  @moduledoc """
  Mars is responsible for orchestrating Readers and Rovers.
  """

  def execute_mission do
    final_rovers = for r <- Rover.Reader.file("test.txt"), do: Rover.navigate(r)
    Rover.Writer.file("out.txt", final_rovers)
  end
end
