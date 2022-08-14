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

  test "navigate past max y" do
    rover = %Mars.Rover{
      x: 1,
      y: 1,
      heading: :north,
      commands: [:forward],
      max_x: 1,
      max_y: 1
    }

    rover = Mars.navigate(rover)
    assert rover.y == 0
  end

  test "navigate past min y" do
    rover = %Mars.Rover{
      x: 1,
      y: 0,
      heading: :south,
      commands: [:forward],
      max_x: 1,
      max_y: 1
    }

    rover = Mars.navigate(rover)
    assert rover.y == 1
  end

  test "navigate past max x" do
    rover = %Mars.Rover{
      x: 1,
      y: 1,
      heading: :east,
      commands: [:forward],
      max_x: 1,
      max_y: 1
    }

    rover = Mars.navigate(rover)
    assert rover.x == 0
  end

  test "navigate past min x" do
    rover = %Mars.Rover{
      x: 0,
      y: 1,
      heading: :west,
      commands: [:forward],
      max_x: 1,
      max_y: 1
    }

    rover = Mars.navigate(rover)
    assert rover.x == 1
  end
end
