defmodule Gridworld.Environment do
  # Hardcoded dynamics of the system. Not known to the agent.

  @type cell :: {1..5, 1..5}
  @type action :: :n | :s | :e | :w
  @type reward :: float()

  @spec dynamics(cell, action) :: {cell, reward}

  # teleport squares
  def dynamics({2, 5}, _), do: {{2, 1}, 10}
  def dynamics({4, 5}, _), do: {{4, 3}, 5}

  # edges
  def dynamics(cell = {_, 5}, :n), do: {cell, -1}
  def dynamics(cell = {_, 1}, :s), do: {cell, -1}
  def dynamics(cell = {1, _}, :w), do: {cell, -1}
  def dynamics(cell = {5, _}, :e), do: {cell, -1}

  # other
  def dynamics({x, y}, :n), do: {{x, y + 1}, 0}
  def dynamics({x, y}, :s), do: {{x, y - 1}, 0}
  def dynamics({x, y}, :e), do: {{x + 1, y}, 0}
  def dynamics({x, y}, :w), do: {{x - 1, y}, 0}
end
