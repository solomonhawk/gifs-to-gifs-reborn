defmodule Ui.GameController do
  use Ui, :controller

  alias GameApp.Server, as: GameServer

  plug :require_player
  plug :set_cache_headers

  def new(conn, _) do
    render(conn, "new.html")
  end

  def join(conn, %{"id" => shortcode}) do
    redirect(conn, to: Routes.game_path(conn, :show, shortcode))
  end

  def create(conn, _params) do
    config = GameApp.Config.create(%{ min_players: 2, reaction_selection_timeout: 0 })
    shortcode = GameServer.generate_shortcode()
    player = get_session(conn, :current_player)

    case GameApp.ServerSupervisor.start_game(shortcode, player, config) do
      {:ok, _pid} ->
        redirect(conn, to: Routes.game_path(conn, :show, shortcode))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Error! Unable to create game.")
        |> redirect(to: Routes.game_path(conn, :new))
    end
  end

  def show(conn, %{"id" => shortcode}) do
    player = get_session(conn, :current_player)

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
        |> redirect(to: Routes.game_path(conn, :new))
    end
  end

  defp generate_auth_token(conn) do
    Phoenix.Token.sign(conn, "secret salt", get_session(conn, :current_player))
  end

  defp require_player(conn, _opts) do
    cond do
      get_session(conn, :current_player) ->
        conn

      true ->
        conn
        |> put_session(:referrer, conn.request_path)
        |> redirect(to: Routes.session_path(conn, :new))
        |> halt()
    end
  end

  defp set_cache_headers(conn, _opts) do
    conn
    |> Plug.Conn.put_resp_header("cache-control", "no-store, private")
    |> Plug.Conn.put_resp_header("pragma", "no-cache")
  end
end
