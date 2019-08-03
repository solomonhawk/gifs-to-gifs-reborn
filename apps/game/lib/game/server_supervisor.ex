defmodule Game.ServerSupervisor do
  use DynamicSupervisor

  def start_link(_) do
    DynamicSupervisor.start_link(__MODULE__, :ok, name:  __MODULE__)
  end

  @impl true
  def init(_) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_game(shortcode, player) do
    child_spec = %{
      id: Game.Server,
      start: {Game.Server, :start_link, [shortcode, player]},
      restart: :transient
    }

    DynamicSupervisor.start_child(__MODULE__, child_spec)
  end

  def stop_game(shortcode) do
    child_pid = Game.Server.game_pid(shortcode)
    DynamicSupervisor.terminate_child(__MODULE__, child_pid)
  end
end
