defmodule GifMe.DB.Accounts do
  alias GifMe.DB.Repo
  alias GifMe.DB.Accounts.{User, Role}

  def create_user(attrs \\ %{}) do
    User.changeset(%User{}, attrs)
    |> Repo.insert()
  end

  def create_role(attrs \\ %{}) do
    Role.changeset(%Role{}, attrs)
    |> Repo.insert()
  end
end
