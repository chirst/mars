defmodule MarsTest do
  use ExUnit.Case
  doctest Mars

  test "executes mission" do
    assert Mars.execute_mission() == :ok
  end
end
