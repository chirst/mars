defmodule Mars do
  @moduledoc """
  Mars is responsible for orchestrating readers and rovers.
  """

  def execute_mission do
    for r <- Reader.rovers_from_file("test.txt"), do: r |> Rover.navigate
  end
end
