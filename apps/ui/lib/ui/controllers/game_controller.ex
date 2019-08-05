defmodule Ui.GameController do
  use Ui, :controller

  plug :require_player

  def new(conn, _) do
    render(conn, "new.html")
  end

  def join(conn, %{"id" => shortcode}) do
    redirect(conn, to: Routes.game_path(conn, :show, shortcode))
  end

  def create(conn, _) do
    shortcode = GameApp.Server.generate_shortcode()
    player = get_session(conn, :current_player)

    case GameApp.ServerSupervisor.start_game(shortcode, player) do
      {:ok, _pid} ->
        redirect(conn, to: Routes.game_path(conn, :show, shortcode))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Error! Unable to create game.")
        |> redirect(to: Routes.game_path(conn, :new))
    end
  end

  def show(conn, %{"id" => shortcode}) do
    case GameApp.Server.game_pid(shortcode) do
      pid when is_pid(pid) ->
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

  defp generate_auth_token(conn) do
    current_player = get_session(conn, :current_player)
    Phoenix.Token.sign(conn, "secret salt", current_player)
  end
end
