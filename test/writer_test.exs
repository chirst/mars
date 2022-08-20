defmodule WriterTest do
  use ExUnit.Case
  doctest Rover.Writer

  test "line" do
    output = Rover.new(3, 4, :north, [], 5, 6) |> Rover.Writer.line()
    assert output == "3 4 N"
  end
end
