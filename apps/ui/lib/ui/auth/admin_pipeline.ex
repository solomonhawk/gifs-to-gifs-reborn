defmodule GifMe.Ui.AdminPipeline do
  import Plug.Conn
  import Guardian.Plug

  def init(opts), do: opts

  def call(conn, _opts) do
    current_user = current_resource(conn)

    case current_user.is_admin? do
      false ->
        conn
        |> Phoenix.Controller.put_flash(:error, "Unauthorized")
        |> Phoenix.Controller.redirect(to: "/")
        |> halt()

      true ->
        conn
    end
  end
end
