defmodule GifMe.Game.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Registry, keys: :unique, name: GifMe.Game.Registry}
      | Application.get_env(:game, :children)
    ]

    _ = :ets.new(:games_table, [:public, :named_table])

    opts = [strategy: :one_for_one, name: GifMe.Game.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
