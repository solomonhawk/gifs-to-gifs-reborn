defmodule Game.Server do
  use GenServer
  require Logger

  @game_timeout :timer.minutes(10)
  @round_start_timeout :timer.seconds(5)

  def start_link(shortcode, player) do
    GenServer.start_link(
      __MODULE__,
      Game.create(shortcode, player),
      name: via_tuple(shortcode)
    )
  end

  ### Client API

  def summary(shortcode) do
    GenServer.call(via_tuple(shortcode), :summary)
  end

  def join(shortcode, player) do
    GenServer.cast(via_tuple(shortcode), {:player_join, player})
  end

  def leave(shortcode, player) do
    GenServer.cast(via_tuple(shortcode), {:player_leave, player})
  end

  def start_game(shortcode) do
    GenServer.cast(via_tuple(shortcode), :start_game)
  end

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

  ###

  @doc """
  Returns a tuple used to register and lookup a game server process by name.
  """
  def via_tuple(shortcode) do
    {:via, Registry, {Game.Registry, "game:" <> shortcode}}
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
