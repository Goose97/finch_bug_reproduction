defmodule Mix.Tasks.Reproduce do
  use Mix.Task

  def run(_) do
    Mix.Task.run("app.start")
    FinchBugReproduce.Client.request(15)
  end
end
