defmodule Ui.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    # GameApp.ServerSupervisor.start_game("ABCD", %{id: "Sol"})
    # IO.inspect GameApp.Server.summary("ABCD")

    children = [
      Ui.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Ui.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    Ui.Endpoint.config_change(changed, removed)
    :ok
  end
end
