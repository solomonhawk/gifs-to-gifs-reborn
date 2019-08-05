defmodule Ui.GameController do
  use Ui, :controller

  plug :require_player

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, _params) do
    shortcode = GameApp.Server.generate_shortcode()

    case GameApp.ServerSupervisor.start_game(shortcode, get_session(conn, :current_player)) do
      {:ok, _pid} ->
        redirect(conn, to: Routes.game_path(conn, :show, shortcode))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Error! Unable to create game.")
        |> redirect(to: Routes.game_path(conn, :new))
    end
  end

  def show(conn, %{"id" => shortcode}) do
    IO.inspect(shortcode)

    conn
    |> assign(:shortcode, shortcode)
    |> render("show.html")
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
end
