defmodule Gridworld.Agent do
  require Logger
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    {:ok, state}
  end
end
