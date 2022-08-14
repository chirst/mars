defmodule MarsTest do
  use ExUnit.Case
  doctest Mars

  test "executes mission" do
    [r1, r2] = Mars.execute_mission
    assert r1.x == 1
    assert r1.y == 3
    assert r1.heading == :north
    assert r2.x == 5
    assert r2.y == 1
    assert r2.heading == :east
  end
end
