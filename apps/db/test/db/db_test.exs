defmodule GifMe.DB.Test do
  use ExUnit.Case, async: true
  import Ecto.Changeset

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

  test "allows the player role to be created" do
    role = role_changeset("player")
    assert role.valid?

    Repo.insert!(role)
  end

  test "disallows roles that aren't 'player' or 'admin'" do
    role = role_changeset("webmaster")
    refute role.valid?

    assert type: ["is invalid"] in errors_on(role)
  end

  test "validates uniqueness of role types" do
    role = role_changeset("admin")
    Repo.insert!(role)

    {:error, changeset} = Repo.insert(role)

    refute changeset.valid?

    assert type: ["has already been taken"] in normalized_errors(changeset)
  end

  test "allows valid users to be inserted" do
    %{id: id} = insert_role("player")
    user = User.changeset(%User{}, %{@user_params | role_id: id})
    assert user.valid?

    Repo.insert!(user)
  end

  test "disallows inserting users without a specified role_id" do
    user = User.changeset(%User{}, @user_params)
    refute user.valid?

    assert type: ["has already been taken"] in errors_on(user)
  end

  test "validates uniqueness of user emails" do
    %{id: id} = insert_role("player")
    user = User.changeset(%User{}, %{@user_params | role_id: id})
    Repo.insert!(user)

    {:error, changeset} = Repo.insert(user)

    assert email: ["has already been taken"] in errors_on(changeset)
  end

  # private

  defp role_changeset(type) do
    Role.changeset(%Role{}, %{type: type})
  end

  defp insert_role(type) do
    Repo.insert!(role_changeset(type))
  end

  defp errors_on(changeset) do
    normalized_errors(changeset)
  end

  defp errors_on(model, data) do
    normalized_errors(model.__struct__.changeset(model, data))
  end

  defp normalized_errors(changeset) do
    traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
