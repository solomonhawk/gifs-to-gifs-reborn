defmodule GameApp.ServerSupervisor do
  @moduledoc """
  A dynamic supervisor that supervises child `GameApp.Server` processes.
  """

  alias __MODULE__, as: ServerSupervisor

  @type player :: %{id: String.t()}

  use DynamicSupervisor

  def start_link(_) do
    DynamicSupervisor.start_link(ServerSupervisor, :ok, name: ServerSupervisor)
  end

  @impl true
  def init(_) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  @doc """
  Starts a game server with the given shortcode and creator(player).

  Returns `{:ok, pid}` or `{:error, any}`.

  ## Examples

      iex> GameApp.ServerSupervisor.start_game("ABCD", %{id: "Gamer"})
      {:ok, pid}

  """
  @spec start_game(String.t(), player()) :: {:ok, pid()} | {:error, any()}
  def start_game(shortcode, player) do
    child_spec = %{
      id: GameApp.Server,
      start: {GameApp.Server, :start_link, [shortcode, player]},
      # don't restart game server processes that exit normally
      restart: :transient
    }

    DynamicSupervisor.start_child(ServerSupervisor, child_spec)
  end

  def stop_game(shortcode) do
    child_pid = GameApp.Server.game_pid(shortcode)
    DynamicSupervisor.terminate_child(ServerSupervisor, child_pid)
  end
end
