defmodule RoverTest do
  use ExUnit.Case
  doctest Rover

  test "navigate" do
    rover =
      Rover.new(
        1,
        2,
        :north,
        [
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
        5,
        6
      )
      |> Rover.navigate()

    assert rover.x == 1
    assert rover.y == 3
    assert rover.heading == :north
  end

  test "navigate past max y" do
    rover =
      Rover.new(
        1,
        1,
        :north,
        [:forward],
        1,
        1
      )
      |> Rover.navigate()

    assert rover.y == 0
  end

  test "navigate past min y" do
    rover =
      Rover.new(
        1,
        0,
        :south,
        [:forward],
        1,
        1
      )
      |> Rover.navigate()

    assert rover.y == 1
  end

  test "navigate past max x" do
    rover =
      Rover.new(
        1,
        1,
        :east,
        [:forward],
        1,
        1
      )
      |> Rover.navigate()

    assert rover.x == 0
  end

  test "navigate past min x" do
    rover =
      Rover.new(
        0,
        1,
        :west,
        [:forward],
        1,
        1
      )
      |> Rover.navigate()

    assert rover.x == 1
  end
end
