defmodule GameApp.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Registry, keys: :unique, name: GameApp.Registry},
      GameApp.ServerSupervisor
    ]

    opts = [strategy: :one_for_one, name: GameApp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
