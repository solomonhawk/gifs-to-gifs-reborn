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

  defp current_player(socket) do
    socket.assigns.current_player
  end
end
