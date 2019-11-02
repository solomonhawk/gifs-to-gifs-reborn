defmodule GifMe.Ui.GameChannel do
  use GifMe.Ui, :channel

  alias GifMe.Ui.{Presence, ChannelWatcher}
  alias GifMe.Game.Player
  alias GifMe.Game.Server, as: GameServer

  require Logger

  def join("games:" <> shortcode, _params, socket) do
    case GameServer.game_pid(shortcode) do
      pid when is_pid(pid) ->
        send(self(), {:after_join, shortcode})
        {:ok, socket}

      nil ->
        {:error, %{reason: "Game does not exist!"}}
    end
  end

  def leave(shortcode, player, socket) do
    _ = Logger.info("Player left '#{shortcode}', #{player.name}.")
    GameServer.leave(shortcode, player)
    broadcast_game_state(shortcode, socket)
  end

  def handle_info({:after_join, shortcode}, socket) do
    monitor_channel(shortcode, socket)
    broadcast_game_state(shortcode, socket)
    push(socket, "presence_state", Presence.list(socket))

    {:ok, _} =
      Presence.track(socket, current_player(socket).name, %{
        online_at: inspect(System.system_time(:second))
      })

    {:noreply, socket}
  end

  def handle_info(:broadcast_update, socket) do
    {shortcode, _} = game_context(socket)
    broadcast_game_state(shortcode, socket)
    {:noreply, socket}
  end

  def handle_in("start_game", _params, socket) do
    {shortcode, player} = game_context(socket)

    handle_creator_action(shortcode, player, socket, fn ->
      GameServer.start_game(shortcode)
      broadcast_game_state(shortcode, socket)
    end)
  end

  def handle_in("start_round", _params, socket) do
    {shortcode, _} = game_context(socket)

    handle_action(shortcode, socket, fn ->
      GameServer.start_round(shortcode, self())
      broadcast_game_state(shortcode, socket)
    end)
  end

  def handle_in("select_prompt", %{"prompt" => prompt}, socket) do
    {shortcode, player} = game_context(socket)

    handle_funmaster_action(shortcode, player, socket, fn ->
      GameServer.select_prompt(shortcode, prompt, self())
      broadcast_game_state(shortcode, socket)
    end)
  end

  def handle_in("select_reaction", %{"reaction" => reaction}, socket) do
    {shortcode, player} = game_context(socket)

    handle_action(shortcode, socket, fn ->
      GameServer.select_reaction(shortcode, player, reaction, self())
      broadcast_game_state(shortcode, socket)
    end)
  end

  # No winner selected, happens if all players don't submit reactions in time
  def handle_in("select_winner", %{"winner" => nil}, socket) do
    {shortcode, player} = game_context(socket)

    handle_funmaster_action(shortcode, player, socket, fn ->
      GameServer.select_winner(shortcode, nil, self())
      broadcast_game_state(shortcode, socket)
    end)
  end

  def handle_in("select_winner", %{"winner" => winner}, socket) do
    {shortcode, player} = game_context(socket)

    handle_funmaster_action(shortcode, player, socket, fn ->
      GameServer.select_winner(shortcode, to_struct(Player, winner), self())
      broadcast_game_state(shortcode, socket)
    end)
  end

  # private

  defp monitor_channel(shortcode, socket) do
    :ok =
      ChannelWatcher.monitor(:games, self(), {
        __MODULE__,
        :leave,
        [shortcode, current_player(socket), socket]
      })
  end

  defp current_player(socket) do
    socket.assigns.current_player
  end

  defp handle_creator_action(shortcode, player, socket, callback) do
    with {:ok, _pid} <- find_server(shortcode),
         {:ok, summary} <- game_summary(shortcode),
         {:ok} <- user_is_creator(player, summary) do
      callback.()
      {:noreply, socket}
    else
      {:error, reason} -> {:reply, {:error, %{reason: reason}}, socket}
    end
  end

  defp handle_funmaster_action(shortcode, player, socket, callback) do
    with {:ok, _pid} <- find_server(shortcode),
         {:ok, summary} <- game_summary(shortcode),
         {:ok} <- user_is_funmaster(player, summary) do
      callback.()
      {:noreply, socket}
    else
      {:error, reason} -> {:reply, {:error, %{reason: reason}}, socket}
    end
  end

  defp handle_action(shortcode, socket, callback) do
    with {:ok, _pid} <- find_server(shortcode) do
      callback.()
      {:noreply, socket}
    else
      {:error, reason} -> {:reply, {:error, %{reason: reason}}, socket}
    end
  end

  defp game_context(%{topic: "games:" <> shortcode} = socket) do
    {shortcode, current_player(socket)}
  end

  defp find_server(shortcode) do
    case GameServer.game_pid(shortcode) do
      pid when is_pid(pid) ->
        {:ok, pid}

      nil ->
        {:error, "Game does not exist"}
    end
  end

  defp user_is_creator(player, summary) do
    if player == Map.get(summary, :creator) do
      {:ok}
    else
      {:error, "Only the creator can do that"}
    end
  end

  defp user_is_funmaster(player, summary) do
    if player == Map.get(summary, :funmaster) do
      {:ok}
    else
      {:error, "Only the funmaster can do that"}
    end
  end

  defp game_summary(shortcode) do
    {:ok, GameServer.summary(shortcode)}
  end

  defp broadcast_game_state(shortcode, socket) do
    with {:ok, summary} <- game_summary(shortcode) do
      broadcast!(socket, "game_summary", summary)
    end
  end

  defp to_struct(kind, attrs) do
    struct = struct(kind)

    Enum.reduce(Map.to_list(struct), struct, fn {k, _}, acc ->
      case Map.fetch(attrs, Atom.to_string(k)) do
        {:ok, v} -> %{acc | k => v}
        :error -> acc
      end
    end)
  end
end
