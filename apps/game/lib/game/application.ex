defmodule GameApp.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Registry, keys: :unique, name: GameApp.Registry}
      | Application.get_env(:game, :children)
    ]

    _ = :ets.new(:games_table, [:public, :named_table])

    opts = [strategy: :one_for_one, name: GameApp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
