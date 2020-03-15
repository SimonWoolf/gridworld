defmodule Gridworld do
  use Application
  alias Gridworld.Policy
  alias Gridworld.Environment
  alias Gridworld.ConsoleOutput

  @grid_height 5
  @grid_width 5
  @cells for x <- 0..@grid_width-1, y <- 0..@grid_height-1, do: {x, y}
  @actions [:n, :s, :e, :w]
  @initial_action_vals @actions
                       |> Enum.map(&{&1, 0})
                       |> Enum.into(Map.new())

  @discount_rate 0.9

  def start(_type, _args) do
    # {:ok, agent_pid} =
    #   Gridworld.Agent.start_link()
    IO.inspect @cells

    # the state action values for the random policy
    # Origin is top left, grid is list of rows, as that's convenient for
    # drawing the table to the console
    q_π =
      for row <- 1..@grid_height do
        for cell <- 1..@grid_width do
          @initial_action_vals
        end
      end

    v_π =
      for row <- 1..@grid_height do
        for cell <- 1..@grid_width do
          0
        end
      end

    policy = %Policy{epsilon: 0}

    explore_loop(q_π, v_π, policy, Enum.random(@cells), 0)

    {:ok, self()}
  end

  # start with random policy for now
  def explore_loop(q_π, v_π, policy, state, total_return) do
    action = choose_action(q_π, state, policy)
    {next_state, reward} = Environment.dynamics(state, action)

    # Update the value of this action to the reward plus discounted value of
    # the state it puts us in. NB: by replacing the current value entirely,
    # this seems like it assumes that there's no randomness in the dynamics at
    # least as far as the the next state is concerned. If there's randomness,
    # presumably we want to also weight the current estimate of the action
    # value some, rather than completely updating it? not sure how much though.
    q_π = update_q(q_π, state, action, value_at(v_π, state) * @discount_rate + reward)
    v_π = update_v(v_π, state, state_value(q_π, state, policy))

    new_total_return = total_return + reward
    ConsoleOutput.display(next_state, v_π, new_total_return)
    explore_loop(q_π, v_π, policy, next_state, new_total_return)
  end

  def choose_action(q, state, %Policy{epsilon: epsilon}) do
    # TODO -- generalise, maybe return a probability distribution and have the caller actually pick an action?
    Enum.random(@actions)
  end

  # v_pi(s) = sum over a of [ pi(a|s) * q_pi(s, a) ]
  def state_value(q, state, %Policy{epsilon: epsilon}) do
    action_values = value_at(q, state)
    # TODO -- generalise, currently assuming random
    Enum.map(action_values, fn {action, value} -> 0.25 * value end)
    |> Enum.sum()
  end

  def value_at(q_or_x, {x, y}) do
    q_or_x
    |> Enum.at(y)
    |> Enum.at(x)
  end

  def update_q(q, {x, y}, action, new_action_value) do
    List.update_at(q, y, fn row ->
      List.update_at(row, x, fn action_vals ->
        Map.put(action_vals, action, new_action_value)
      end)
    end)
  end

  def update_v(v, {x, y}, new_state_value) do
    List.update_at(v, y, fn row ->
      List.replace_at(row, x, new_state_value)
    end)
  end
end
