defmodule Game.Server do
  use GenServer

  def start_link(shortcode, player) do
    GenServer.start_link(
      __MODULE__,
      Game.create(shortcode, player),
      name: via_tuple(shortcode)
    )
  end

  def summary(shortcode) do
    GenServer.call(via_tuple(shortcode), :summary)
  end

  def join(shortcode, player) do
    GenServer.cast(via_tuple(shortcode), {:player_join, player})
  end

  def leave(shortcode, player) do
    GenServer.cast(via_tuple(shortcode), {:player_leave, player})
  end

  def start_round(shortcode) do
    GenServer.cast(via_tuple(shortcode), :start_round)
  end

  @impl true
  def init(game) do
    {:ok, game}
  end

  @impl true
  def handle_call(:summary, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_cast({:player_join, player}, state) do
    {:noreply, Game.player_join(state, player)}
  end

  @impl true
  def handle_cast({:player_leave, player}, state) do
    {:noreply, Game.player_leave(state, player)}
  end

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
