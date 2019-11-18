defmodule GifMe.Auth do
  @moduledoc """
  Documentation for Auth.
  """

  import Bcrypt, only: [check_pass: 2]

  alias GifMe.DB.Accounts
  alias GifMe.Auth.Guardian

  defp login(conn, user) do
    conn
    |> Guardian.Plug.sign_in(user)
  end

  def authenticate(conn, %{"email" => email, "password" => password}) do
    user = Accounts.find_user(email: email)

    cond do
      user && check_pass(user, password) ->
        {:ok, login(conn, user), user}

      user ->
        {:error, :unauthorized, conn}

      true ->
        {:error, :not_found, conn}
    end
  end

  def logout(conn) do
    Guardian.Plug.sign_out(conn)
  end
end
