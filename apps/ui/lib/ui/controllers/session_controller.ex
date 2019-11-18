defmodule GifMe.Ui.SessionController do
  use GifMe.Ui, :controller

  import GifMe.Ui.Router.Helpers

  alias GifMe.Auth
  alias GifMe.Auth.Guardian

  plug :scrub_params, "session" when action in ~w(create)a

  def new(conn, _params) do
    case Guardian.Plug.current_resource(conn) do
      nil -> render(conn, "new.html")
      _user -> redirect(conn, to: game_path(conn, :new))
    end
  end

  def create(conn, %{"session" => user_params}) do
    case Auth.authenticate(conn, user_params) do
      {:ok, conn, user} ->
        conn
        |> put_flash(:info, "Welcome back #{user.nickname}!")
        |> redirect(to: game_path(conn, :new))

      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid email/password combination")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> Auth.logout()
    |> put_flash(:info, "See you later!")
    |> redirect(to: session_path(conn, :new))
  end
end
