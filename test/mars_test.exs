defmodule MarsTest do
  use ExUnit.Case
  doctest Mars

  test "navigate" do
    rover = %Mars.Rover{
      x: 1,
      y: 2,
      heading: :north,
      commands: [
        :left,
        :forward,
        :left,
        :forward,
        :left,
        :forward,
        :left,
        :forward,
        :forward
      ],
      max_x: 5,
      max_y: 6
    }

    rover = Mars.navigate(rover)
    assert rover.x == 1
    assert rover.y == 3
    assert rover.heading == :north
  end
end
