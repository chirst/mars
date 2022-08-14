defmodule RoverTest do
  use ExUnit.Case
  doctest Rover

  test "navigate" do
    rover = %Rover{
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

    rover = rover |> Rover.navigate
    assert rover.x == 1
    assert rover.y == 3
    assert rover.heading == :north
  end

  test "navigate past max y" do
    rover = %Rover{
      x: 1,
      y: 1,
      heading: :north,
      commands: [:forward],
      max_x: 1,
      max_y: 1
    }

    rover = rover |> Rover.navigate
    assert rover.y == 0
  end

  test "navigate past min y" do
    rover = %Rover{
      x: 1,
      y: 0,
      heading: :south,
      commands: [:forward],
      max_x: 1,
      max_y: 1
    }

    rover = rover |> Rover.navigate
    assert rover.y == 1
  end

  test "navigate past max x" do
    rover = %Rover{
      x: 1,
      y: 1,
      heading: :east,
      commands: [:forward],
      max_x: 1,
      max_y: 1
    }

    rover = rover |> Rover.navigate
    assert rover.x == 0
  end

  test "navigate past min x" do
    rover = %Rover{
      x: 0,
      y: 1,
      heading: :west,
      commands: [:forward],
      max_x: 1,
      max_y: 1
    }

    rover = rover |> Rover.navigate
    assert rover.x == 1
  end
end
