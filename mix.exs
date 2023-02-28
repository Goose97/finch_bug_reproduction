defmodule FinchBugReproduce.MixProject do
  use Mix.Project

  def project do
    [
      app: :finch_bug_reproduce,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {FinchBugReproduce.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug, "~> 1.10"},
      {:bandit, ">= 0.5.10"},
      {:finch, github: "Goose97/finch"}
    ]
  end
end
