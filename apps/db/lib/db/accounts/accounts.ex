defmodule GifMe.DB.Accounts do
  alias GifMe.DB.Repo
  alias GifMe.DB.Accounts.{User, Role}

  # Users

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(user, attrs \\ %{}) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def find_user(attrs \\ %{}) do
    User
    |> Repo.get_by(attrs)
    |> Repo.preload(:role)
    |> User.with_computed_fields()
  end

  # UserRoles

  def is_admin?(user) do
    user.role.type == "admin"
  end

  # Roles

  def create_role(attrs \\ %{}) do
    %Role{}
    |> Role.changeset(attrs)
    |> Repo.insert()
  end

  def find_role(attrs \\ %{}) do
    Repo.get_by(Role, attrs)
  end
end
