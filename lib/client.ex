defmodule FinchBugReproduce.Client do
  def request(duration) do
    timeout = 10_000
    IO.puts("CLIENT: start the request with timeout=#{timeout}")
    Finch.build(:get, "https://localhost:4000?sleep=#{duration}")
    |> Finch.request(MyFinch, receive_timeout: timeout)
  end
end
