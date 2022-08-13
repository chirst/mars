defmodule MarsTest do
  use ExUnit.Case
  doctest Mars

  test "navigate" do
    rover = Mars.new_rover() |> Mars.navigate()
    assert rover.x == 1
    assert rover.y == 3
    assert rover.heading == :north
  end
end
