defmodule GifMe.Ui.SessionController do
  use GifMe.Ui, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"player" => %{"name" => name}}) do
    player = GifMe.Game.Player.create(id: UUID.uuid4(), name: name)

    conn
    |> put_session(:current_player, player)
    |> redirect_back_or_to_new_game()
  end

  def delete(conn, _params) do
    conn
    |> put_session(:current_player, nil)
    |> redirect(to: "/")
  end

  defp redirect_back_or_to_new_game(conn) do
    path = get_session(conn, :referrer) || Routes.game_path(conn, :new)

    conn
    |> put_session(:referrer, nil)
    |> redirect(to: path)
  end
end
