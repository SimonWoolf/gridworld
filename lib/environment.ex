defmodule Gridworld.Environment do
  # Hardcoded dynamics of the system. Not known to the agent.
  #

  @type cell :: {0..4, 0..4}
  @type action :: :n | :s | :e | :w
  @type reward :: float()

  @spec dynamics(cell, action) :: {cell, reward}

  # teleport squares
  def dynamics({1, 0}, _), do: {{1, 4}, 10}
  def dynamics({3, 0}, _), do: {{3, 2}, 5}

  # edges
  def dynamics(cell = {_, 0}, :n), do: {cell, -1}
  def dynamics(cell = {_, 4}, :s), do: {cell, -1}
  def dynamics(cell = {0, _}, :w), do: {cell, -1}
  def dynamics(cell = {4, _}, :e), do: {cell, -1}

  # other
  def dynamics({x, y}, :n), do: {{x, y - 1}, 0}
  def dynamics({x, y}, :s), do: {{x, y + 1}, 0}
  def dynamics({x, y}, :e), do: {{x + 1, y}, 0}
  def dynamics({x, y}, :w), do: {{x - 1, y}, 0}
end
