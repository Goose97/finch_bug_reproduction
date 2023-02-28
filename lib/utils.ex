defmodule FinchBugReproduce.Utils do
  def log_with_time(payload) do
    time = NaiveDateTime.utc_now() |> NaiveDateTime.to_time() |> Time.to_iso8601()
    IO.puts("#{time} #{payload}")
  end
end
