defmodule Gridworld.MixProject do
  use Mix.Project

  def project do
    [
      app: :gridworld,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :table_rex],
      mod: {Gridworld, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:table_rex, "~> 2.0.0"}
    ]
  end
end
