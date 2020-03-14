defmodule Gridworld do
  use Application

  def start(_type, _args) do
    {:ok, agent_pid} =
      Gridworld.Agent.start_link()
  end
end
