defmodule GifMe.Game.ServerSupervisor do
  @moduledoc """
  A dynamic supervisor that supervises child `GifMe.Game.Server` processes.
  """

  alias __MODULE__, as: ServerSupervisor
  alias GifMe.Game
  alias Game.Player
  alias Game.Config, as: GameConfig

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

      iex> Game.ServerSupervisor.start_game("ABCD", %{id: "Gamer"})
      {:ok, pid}

  """
  @spec start_game(String.t(), Player.t(), GameConfig.t()) :: {:ok, pid()} | {:error, any()}
  def start_game(shortcode, player, config \\ %GameConfig{}) do
    child_spec = %{
      id: Game.Server,
      start: {Game.Server, :start_link, [shortcode, player, config]},
      # don't restart game server processes that exit normally
      restart: :transient
    }

    DynamicSupervisor.start_child(ServerSupervisor, child_spec)
  end

  @doc """
  Stops a game server with the given shortcode.

  Returns `:ok` or `{:error, :not_found}`.
  """
  @spec stop_game(String.t()) :: :ok | {:error, :not_found}
  def stop_game(shortcode) do
    child_pid = Game.Server.game_pid(shortcode)
    DynamicSupervisor.terminate_child(ServerSupervisor, child_pid)
  end

  @doc """
  Finds a game server with the given shortcode.

  Returns `:ok` or `{:error, :not_found}`.
  """
  @spec find_game(String.t()) :: {:ok, pid()} | {:error, :not_found}
  def find_game(shortcode) do
    case Game.Server.game_pid(shortcode) do
      pid when is_pid(pid) ->
        {:ok, pid}

      nil ->
        {:error, :not_found}
    end
  end
end
