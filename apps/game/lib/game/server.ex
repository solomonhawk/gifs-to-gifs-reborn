defmodule GameApp.Server do
  @moduledoc """
  `GameApp.Server` provides a stateful process that maintains an internal game
  state and provides a public API for interacting with the game.
  """

  use GenServer

  alias __MODULE__, as: Server
  alias GameApp.Game

  require Logger

  @game_timeout :timer.minutes(10)
  @round_start_timeout :timer.seconds(5)

  def start_link(shortcode, player) do
    GenServer.start_link(Server, Game.create(shortcode, player), name: via_tuple(shortcode))
  end

  ### Client API

  @doc """
  Returns a summary of the game state for a game with the given shortcode.
  """
  def summary(shortcode) do
    GenServer.call(via_tuple(shortcode), :summary)
  end

  @doc """
  Joins a player to the game with the given shortcode.
  """
  def join(shortcode, player) do
    GenServer.cast(via_tuple(shortcode), {:player_join, player})
  end

  @doc """
  Removes a player from the game with the given shortcode.
  """
  def leave(shortcode, player) do
    GenServer.cast(via_tuple(shortcode), {:player_leave, player})
  end

  @doc """
  Starts the game with the given shortcode.
  """
  def start_game(shortcode) do
    GenServer.cast(via_tuple(shortcode), :start_game)
  end

  @doc """
  Starts the next round for the game with the given shortcode.
  """
  def start_round(shortcode) do
    GenServer.cast(via_tuple(shortcode), :start_round)
  end

  ### Server API

  @impl true
  def init(game) do
    Logger.info("Spawned game server process with code '#{game.shortcode}'.")
    {:ok, game, @game_timeout}
  end

  @impl true
  def handle_call(:summary, _from, game) do
    {:reply, game, game, @game_timeout}
  end

  @impl true
  def handle_cast({:player_join, player}, game) do
    {:noreply, Game.player_join(game, player), @game_timeout}
  end

  @impl true
  def handle_cast({:player_leave, player}, game) do
    {:noreply, Game.player_leave(game, player), @game_timeout}
  end

  @impl true
  def handle_cast(:start_game, game) do
    {:noreply, Game.start_game(game), @game_timeout}
  end

  @impl true
  def handle_cast(:start_round, game) do
    # Advance to prompt selection after @round_start_timeout
    Process.send_after(self(), :round_start_timeout, @round_start_timeout)
    {:noreply, Game.start_round(game), @game_timeout}
  end

  @impl true
  def handle_info(:round_start_timeout, game) do
    {:noreply, Game.start_prompt_selection(game), @game_timeout}
  end

  ### Helpers

  @doc """
  Returns a tuple used to register and lookup a game server process by name.
  """
  def via_tuple(shortcode) do
    {:via, Registry, {GameApp.Registry, "game:" <> shortcode}}
  end

  @doc """
  Returns the `pid` of the game server process registered under the
  given `shortcode`, or `nil` if no process is registered.
  """
  def game_pid(shortcode) do
    shortcode
    |> via_tuple()
    |> GenServer.whereis()
  end
end
