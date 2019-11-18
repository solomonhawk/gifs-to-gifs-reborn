defmodule GifMe.Ui.GameController do
  use GifMe.Ui, :controller

  import GifMe.Ui.Router.Helpers

  alias GifMe.Game.Config, as: GameConfig
  alias GifMe.Game.Server, as: GameServer
  alias GifMe.Game.ServerSupervisor
  alias GifMe.Auth.Guardian

  plug :set_cache_headers

  def new(conn, _) do
    render(conn, "new.html")
  end

  def join(conn, %{"id" => shortcode}) do
    redirect(conn, to: game_path(conn, :show, shortcode))
  end

  def create(conn, _params) do
    config = GameConfig.create(min_players: 2, reaction_selection_timeout: 0)
    shortcode = GameServer.generate_shortcode()
    player = current_player(conn)

    case ServerSupervisor.start_game(shortcode, player, config) do
      {:ok, _pid} ->
        redirect(conn, to: game_path(conn, :show, shortcode))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Error! Unable to create game.")
        |> redirect(to: game_path(conn, :new))
    end
  end

  def show(conn, %{"id" => shortcode}) do
    player = current_player(conn)

    case GameServer.game_pid(shortcode) do
      pid when is_pid(pid) ->
        GameServer.join(shortcode, player)

        conn
        |> assign(:shortcode, shortcode)
        |> assign(:auth_token, generate_auth_token(conn))
        |> render("show.html")

      nil ->
        conn
        |> put_flash(:error, "Game not found!")
        |> redirect(to: game_path(conn, :new))
    end
  end

  defp generate_auth_token(conn) do
    Guardian.Plug.current_token(conn)
  end

  defp current_player(conn) do
    conn.assigns.current_player
  end

  defp set_cache_headers(conn, _opts) do
    conn
    |> Plug.Conn.put_resp_header("cache-control", "no-store, private")
    |> Plug.Conn.put_resp_header("pragma", "no-cache")
  end
end
