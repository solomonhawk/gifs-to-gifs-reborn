defmodule GifMe.Ui.CurrentUser do
  import Plug.Conn
  import Guardian.Plug

  alias GifMe.Game.Player

  def init(opts), do: opts

  def call(conn, _opts) do
    current_user = current_resource(conn)

    conn
    |> assign(:current_user, current_user)
    |> assign(:current_player, current_user && Player.from_user(current_user))
  end
end
