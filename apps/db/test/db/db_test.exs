defmodule GifMe.DB.Test do
  use ExUnit.Case, async: true
  doctest GifMe.DB

  alias GifMe.DB.{Repo, User, Role}

  @user_params %{
    nickname: "Barry Bluejeans",
    email: "barry@bluejeans.com",
    role_id: nil
  }

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  test "allows the admin role to be created" do
    role = role_changeset("admin")
    assert role.valid?

    Repo.insert!(role)
  end

  test "allows the user role to be created" do
    role = role_changeset("user")
    assert role.valid?

    Repo.insert!(role)
  end

  test "only allows roles with a type of 'user' or 'admin'" do
    role = role_changeset("webmaster")
    refute role.valid?

    {:error, changeset} = Repo.insert(role)

    assert Keyword.get(changeset.errors, :type)
  end

  test "validates uniqueness of role types" do
    role = role_changeset("admin")
    Repo.insert!(role)

    {:error, changeset} = Repo.insert(role)

    refute changeset.valid?

    {reason, _constraint} = Keyword.get(changeset.errors, :type)

    assert reason == "has already been taken"
  end

  test "allows valid users to be inserted" do
    %{id: id} = insert_role("user")
    user = User.changeset(%User{}, %{@user_params | role_id: id})
    assert user.valid?

    Repo.insert!(user)
  end

  test "disallows inserting users without a specified role_id" do
    user = User.changeset(%User{}, @user_params)
    {:error, changeset} = Repo.insert(user)

    refute changeset.valid?

    {reason, _constraint} = Keyword.get(changeset.errors, :role_id)

    assert reason == "can't be blank"
  end

  test "validates uniqueness of user emails" do
    %{id: id} = insert_role("user")
    user = User.changeset(%User{}, %{@user_params | role_id: id})
    Repo.insert!(user)

    {:error, changeset} = Repo.insert(user)

    {reason, _constraint} = Keyword.get(changeset.errors, :email)

    assert reason == "has already been taken"
  end

  defp role_changeset(type) do
    Role.changeset(%Role{}, %{type: type})
  end

  defp insert_role(type) do
    Repo.insert!(role_changeset(type))
  end
end
