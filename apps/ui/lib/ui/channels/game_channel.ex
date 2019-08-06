defmodule Ui.GameChannel do
  use Ui, :channel

  def join("games:" <> shortcode, _params, socket) do
    case GameApp.Server.game_pid(shortcode) do
      pid when is_pid(pid) ->
        send(self(), {:after_join, shortcode})
        {:ok, socket}

      nil ->
        {:error, %{reason: "Game does not exist!"}}
    end
  end

  def handle_info({:after_join, shortcode}, socket) do
    summary = GameApp.Server.summary(shortcode)
    push(socket, "game_summary", summary)
    {:noreply, socket}
  end

  def handle_in("start_game", _params, socket) do
    {shortcode, player} = game_context(socket)

    handle_creator_action(shortcode, player, socket, fn ->
      GameApp.Server.start_game(shortcode)
      broadcast_game_state(shortcode, socket)
    end)
  end

  def handle_in("start_round", _params, socket) do
    {shortcode, player} = game_context(socket)

    handle_funmaster_action(shortcode, player, socket, fn ->
      GameApp.Server.start_round(shortcode)
      broadcast_game_state(shortcode, socket)
    end)
  end

  def handle_in("select_prompt", %{"prompt" => prompt}, socket) do
    {shortcode, player} = game_context(socket)

    handle_funmaster_action(shortcode, player, socket, fn ->
      GameApp.Server.select_prompt(shortcode, prompt)
      broadcast_game_state(shortcode, socket)
    end)
  end

  def handle_in("select_reaction", %{"reaction" => reaction}, socket) do
    {shortcode, player} = game_context(socket)

    handle_action(shortcode, socket, fn ->
      GameApp.Server.select_reaction(shortcode, player, reaction)
      broadcast_game_state(shortcode, socket)
    end)
  end

  def handle_in("select_winner", %{"winner" => winner}, socket) do
    {shortcode, player} = game_context(socket)

    handle_funmaster_action(shortcode, player, socket, fn ->
      GameApp.Server.select_winner(shortcode, winner)
      broadcast_game_state(shortcode, socket)
    end)
  end

  # private

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
    case GameApp.Server.game_pid(shortcode) do
      pid when is_pid(pid) ->
        {:ok, pid}

      _ ->
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
    {:ok, GameApp.Server.summary(shortcode)}
  end

  defp broadcast_game_state(shortcode, socket) do
    with {:ok, summary} <- game_summary(shortcode) do
      broadcast!(socket, "game_summary", summary)
    end
  end
end
