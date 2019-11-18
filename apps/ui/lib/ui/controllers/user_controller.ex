defmodule GifMe.Ui.UserController do
  use GifMe.Ui, :controller

  alias GifMe.DB.Accounts
  alias GifMe.DB.Accounts.User
  alias GifMe.Auth

  def new(conn, _) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.find_user(id: id)
    changeset = User.changeset(user)
    render(conn, "show.html", user: user, changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.find_user(id: id)
    changeset = User.changeset(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    player_role = Accounts.find_role(type: "player")

    case Accounts.create_user(Map.put(user_params, "role_id", player_role.id)) do
      {:ok, _user} ->
        conn
        |> login_and_redirect(user_params)

      {:error, changeset} ->
        conn
        |> render("new.html", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.find_user(id: id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated")
        |> redirect(to: Routes.user_path(conn, :show, user.id))

      {:error, changeset} ->
        conn
        |> render("show.html", user: user, changeset: changeset)
    end
  end

  defp login_and_redirect(conn, user_params) do
    case Auth.authenticate(conn, user_params) do
      {:ok, conn, user} ->
        conn
        |> put_flash(:info, "Welcome to gifme")
        |> redirect(to: Routes.user_path(conn, :show, user.id))

      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Oops, something went wrong.")
        |> redirect(to: Routes.session_path(conn, :new))
    end
  end
end
