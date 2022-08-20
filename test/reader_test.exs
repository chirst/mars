defmodule ReaderTest do
  use ExUnit.Case
  doctest Rover.Reader

  test "rovers from file" do
    [first, second] = Rover.Reader.file("test.txt")
    assert first.x == 1
    assert first.y == 2
    assert first.heading == :north
    assert first.max_x == 5
    assert first.max_y == 6

    assert first.commands == [
             :left,
             :forward,
             :left,
             :forward,
             :left,
             :forward,
             :left,
             :forward,
             :forward
           ]

    assert second.x == 3
    assert second.y == 3
    assert second.heading == :east
    assert second.max_x == 5
    assert second.max_y == 6

    assert second.commands == [
             :forward,
             :forward,
             :right,
             :forward,
             :forward,
             :right,
             :forward,
             :right,
             :right,
             :forward
           ]
  end
end
