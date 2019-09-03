defmodule GameApp.Server do
  @moduledoc """
  `GameApp.Server` provides a stateful process that maintains an internal game
  state and provides a public API for interacting with the game.
  """

  use GenServer

  alias __MODULE__, as: Server
  alias GameApp.{Game, Player}
  alias GameApp.Config, as: GameConfig

  require Logger

  @spec start_link(String.t(), Player.t(), GameConfig.t()) ::
          {:ok, pid()} | :ignore | {:error, {:already_started, pid()} | term()}
  def start_link(shortcode, player, config \\ %GameConfig{}) do
    GenServer.start_link(Server, {shortcode, player, config}, name: via_tuple(shortcode))
  end

  ### Client API

  @doc """
  Returns a summary of the game state for a game with the given shortcode.
  """
  @spec summary(String.t()) :: Game.t()
  def summary(shortcode) do
    GenServer.call(via_tuple(shortcode), :summary)
  end

  @doc """
  Joins a player to the game with the given shortcode.
  """
  @spec join(String.t(), Player.t()) :: :ok
  def join(shortcode, player) do
    GenServer.cast(via_tuple(shortcode), {:player_join, player})
  end

  @doc """
  Removes a player from the game with the given shortcode.
  """
  @spec leave(String.t(), Player.t()) :: :ok
  def leave(shortcode, player) do
    GenServer.cast(via_tuple(shortcode), {:player_leave, player})
  end

  @doc """
  Starts the game with the given shortcode.
  """
  @spec start_game(String.t()) :: :ok
  def start_game(shortcode) do
    GenServer.cast(via_tuple(shortcode), :start_game)
  end

  @doc """
  Starts the next round for the game with the given shortcode.
  """
  @spec start_round(String.t(), pid()) :: :ok
  def start_round(shortcode, channel_pid) do
    GenServer.cast(via_tuple(shortcode), {:start_round, channel_pid})
  end

  @doc """
  Selects a prompt to set for the current round.
  """
  @spec select_prompt(String.t(), String.t()) :: :ok
  def select_prompt(shortcode, prompt) do
    GenServer.cast(via_tuple(shortcode), {:select_prompt, prompt})
  end

  @doc """
  Selects a reaction for the given player in the current round.
  """
  @spec select_reaction(String.t(), Player.t(), String.t(), pid()) :: :ok
  def select_reaction(shortcode, player, reaction, channel_pid) do
    GenServer.cast(via_tuple(shortcode), {:select_reaction, player, reaction, channel_pid})
  end

  @doc """
  Selects a winner for the current round.
  """
  @spec select_winner(String.t(), Player.t(), pid()) :: :ok
  def select_winner(shortcode, winner, channel_pid) do
    GenServer.cast(via_tuple(shortcode), {:select_winner, winner, channel_pid})
  end

  ### Server API

  @impl true
  def init({shortcode, player, %GameConfig{game_timeout: game_timeout} = config}) do
    game =
      case :ets.lookup(:games_table, shortcode) do
        [] ->
          game = Game.create(shortcode, player, config)
          :ets.insert(:games_table, {shortcode, game})
          game

        [{^shortcode, game}] ->
          game
      end

    Logger.info("Spawned game server process '#{game.shortcode}'.")
    {:ok, game, game_timeout}
  end

  @impl true
  def handle_call(:summary, _from, game) do
    {:reply, Game.summary(game), game, game.config.game_timeout}
  end

  @impl true
  def handle_cast({:player_join, player}, game) do
    next = Game.player_join(game, player)
    update_ets(game, next)
    {:noreply, next, game.config.game_timeout}
  end

  @impl true
  def handle_cast({:player_leave, player}, game) do
    next = Game.player_leave(game, player)
    update_ets(game, next)

    # NOTE: Why do this? Just let the server time out eventually
    #
    # Maybe shutdown after a players leaves (if none left)
    # Process.send_after(self(), :after_player_leave, @leave_timeout)

    {:noreply, next, game.config.game_timeout}
  end

  @impl true
  def handle_cast(:start_game, game) do
    next = Game.start_game(game)
    update_ets(game, next)

    {:noreply, next, game.config.game_timeout}
  end

  @impl true
  def handle_cast({:start_round, channel_pid}, game) do
    next = Game.start_round(game)
    update_ets(game, next)

    # Advance to prompt selection after game.config.round_start_timeout
    Process.send_after(self(), {:after_round_start, channel_pid}, game.config.round_start_timeout)

    {:noreply, next, game.config.game_timeout}
  end

  @impl true
  def handle_cast({:select_prompt, prompt}, game) do
    next = Game.select_prompt(game, prompt)
    update_ets(game, next)
    {:noreply, next, game.config.game_timeout}
  end

  @impl true
  def handle_cast({:select_reaction, player, reaction, channel_pid}, game) do
    next = Game.select_reaction(game, player, reaction)
    update_ets(game, next)

    # Advance to winner_selection after a reaction is selected, if all reactions selected
    if Game.all_players_reacted?(next) do
      Process.send_after(
        self(),
        {:after_select_reaction, channel_pid},
        game.config.winner_selection_timeout
      )
    end

    {:noreply, next, game.config.game_timeout}
  end

  @impl true
  def handle_cast({:select_winner, winner, channel_pid}, game) do
    next = Game.select_winner(game, winner)
    update_ets(game, next)

    # Advance to next round after game.config.round_end_timeout
    Process.send_after(self(), {:after_select_winner, channel_pid}, game.config.round_end_timeout)

    {:noreply, next, game.config.game_timeout}
  end

  # Info Callbacks

  @impl true
  def handle_info(:after_player_leave, game) do
    if Game.is_empty?(game) do
      {:stop, {:shutdown, :empty_game}, game}
    else
      {:noreply, game, game.config.game_timeout}
    end
  end

  @impl true
  def handle_info({:after_round_start, channel_pid}, game) do
    next = Game.start_prompt_selection(game)
    update_ets(game, next)

    send(channel_pid, :broadcast_update)

    {:noreply, next, game.config.game_timeout}
  end

  @impl true
  def handle_info({:after_select_reaction, channel_pid}, game) do
    next = Game.start_winner_selection(game)
    update_ets(game, next)
    send(channel_pid, :broadcast_update)
    {:noreply, next, game.config.game_timeout}
  end

  @impl true
  def handle_info({:after_select_winner, channel_pid}, game) do
    Server.start_round(game.shortcode, channel_pid)
    send(channel_pid, :broadcast_update)
    {:noreply, game, game.config.game_timeout}
  end

  @impl true
  def handle_info(:timeout, game) do
    {:stop, {:shutdown, :timeout}, game}
  end

  @impl true
  def terminate({:shutdown, :empty_game}, game) do
    :ets.delete(:games_table, game.shortcode)
    Logger.info("Server '#{game.shortcode}' shutdown because all players left.")
    :ok
  end

  def terminate({:shutdown, :timeout}, game) do
    :ets.delete(:games_table, game.shortcode)
    Logger.info("Shutting down game '#{game.shortcode}', timed out.")
    :ok
  end

  def terminate(_reason, game) do
    Logger.info("Game server process terminated '#{game.shortcode}'.")
    :ok
  end

  ### Helpers

  @doc """
  Returns a tuple used to register and lookup a game server process by name.
  """
  @spec via_tuple(String.t()) :: {:via, Registry, {GameApp.Registry, String.t()}}
  def via_tuple(shortcode) do
    {:via, Registry, {GameApp.Registry, "game:" <> shortcode}}
  end

  @doc """
  Returns the `pid` of the game server process registered under the
  given `shortcode`, or `nil` if no process is registered.
  """
  @spec game_pid(String.t()) :: pid() | nil
  def game_pid(shortcode) do
    shortcode
    |> via_tuple()
    |> GenServer.whereis()
  end

  @doc """
  Generates a 4-letter code used as the identifier for a game server.
  """
  @spec generate_shortcode() :: String.t()
  def generate_shortcode() do
    code =
      shortcode_string()
      |> String.downcase()

    # ensure no duplicates
    case game_pid(code) do
      nil ->
        code

      _ ->
        generate_shortcode()
    end
  end

  defp update_ets(game, next) do
    :ets.insert(:games_table, {game.shortcode, next})
  end

  defp shortcode_string() do
    <<a, b, c, d>> = :crypto.strong_rand_bytes(4)

    to_string([
      65 + rem(a, 26),
      65 + rem(b, 26),
      65 + rem(c, 26),
      65 + rem(d, 26)
    ])
  end
end
