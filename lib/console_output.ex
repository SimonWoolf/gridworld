defmodule Gridworld.ConsoleOutput do
  alias TableRex.Table

  def display(new_state, v_π, return) do
    clear_screen()
    IO.puts("State values:")

    Table.new(v_π)
    |> Table.put_column_meta(:all, align: :center)
    |> Table.render!(horizontal_style: :all)
    |> IO.puts()

    IO.puts("Total return: #{return}")
  end

  defp clear_screen do
    IO.puts("\e[H\e[2J")
  end
end
