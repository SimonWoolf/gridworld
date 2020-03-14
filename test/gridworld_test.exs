defmodule GridworldTest do
  use ExUnit.Case
  doctest Gridworld

  test "greets the world" do
    assert Gridworld.hello() == :world
  end
end
