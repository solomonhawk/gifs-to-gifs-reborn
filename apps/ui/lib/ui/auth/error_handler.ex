defmodule GifMe.Ui.AuthErrorHandler do
  import Plug.Conn
  import GifMe.Ui.Router.Helpers

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, _params, _) do
    conn
    |> Phoenix.Controller.put_flash(:error, "You must be signed in to access that page.")
    |> Phoenix.Controller.redirect(to: session_path(conn, :new))
  end
end
