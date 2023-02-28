defmodule FinchBugReproduce.Router do
  use Plug.Router
  use Plug.Debugger
  require Logger

  plug(Plug.Parsers,
    parsers: [:multipart],
    length: 100_000_000
  )

  plug(:match)
  plug(:dispatch)

  get "/" do
    port = find_connection()
    sleep = if conn.params["sleep"], do: String.to_integer(conn.params["sleep"]), else: 5

    spawn(fn ->
      FinchBugReproduce.Utils.log_with_time("SERVER: closing tcp connection after #{sleep} seconds")
      Process.sleep(sleep * 1000)
      FinchBugReproduce.Utils.log_with_time("SERVER: closing tcp connection due to unstable network")
      Port.close(port)
    end)

    Process.sleep(:infinity)
    send_resp(conn, 200, "OK")
  end

  defp find_connection do
    Port.list()
    |> Enum.find(fn port ->
      match?({:ok, _}, :inet.peername(port))
    end)
  end
end
