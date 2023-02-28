defmodule FinchBugReproduce.Application do
  @moduledoc false

  use Application

  @env System.get_env("MIX_ENV")

  def start(_type, _args) do
    bandit_options = [
      port: 4000,
      transport_options: [
        certfile: Path.join(File.cwd!(), "certs/MyCertificate.crt"),
        keyfile: Path.join(File.cwd!(), "certs/MyKey.key")
      ],
      read_timeout: :infinity
    ]

    children = [
      {Bandit, plug: FinchBugReproduce.Router, scheme: :https, options: bandit_options},
      {Finch,
       name: MyFinch,
       pools: %{
         "https://localhost:4000" => [
           size: 1,
           count: 1,
           conn_opts: [
             transport_opts: [
               verify: :verify_none
             ]
           ],
           protocol: :http2
         ]
       }}
    ]

    opts = [strategy: :one_for_one, name: FinchBugReproduce.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
