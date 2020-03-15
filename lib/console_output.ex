defmodule Gridworld.ConsoleOutput do
  def display(new_state, v_π, return, grid_height, grid_width) do
    clear_screen()
    IO.puts("State values:")
    IO.puts(String.duplicate("-", grid_width * 2 + 1)
  end

  defp clear_screen do
    IO.puts("\e[H\e[2J")
  end
end
