defmodule GifMe.DB.UserTest do
  use GifMe.DB.DataCase, async: true

  alias GifMe.DB.Repo
  alias GifMe.DB.Accounts
  alias GifMe.DB.Accounts.{User, Role}

  @valid_attrs %{nickname: "Barry Bluejeans", email: "barry@bluejeans.com", role_id: nil}
  @invalid_attrs %{nickname: nil, email: nil, role_id: nil}

  test "create_user/1 with valid attrs inserts a user" do
    assert {:ok, %Role{} = role} = Accounts.create_role(%{type: "player"})
    assert {:ok, %User{} = user} = Accounts.create_user(%{@valid_attrs | role_id: role.id})
    assert user.nickname == "Barry Bluejeans"
    assert user.email == "barry@bluejeans.com"
    refute user.role_id == nil
  end

  test "create_user/1 with invalid attrs returns error changeset" do
    assert {:error, %Ecto.Changeset{} = changeset} = Accounts.create_user(@invalid_attrs)
    assert %{role_id: ["can't be blank"]} = errors_on(changeset)
  end

  test "nickname can't be blank" do
    assert {:error, %Ecto.Changeset{} = changeset} = Accounts.create_user(Map.delete(@valid_attrs, :nickname))
    assert %{nickname: ["can't be blank"]} = errors_on(changeset)
  end

  test "email can't be blank" do
    assert {:error, %Ecto.Changeset{} = changeset} = Accounts.create_user(Map.delete(@valid_attrs, :email))
    assert %{email: ["can't be blank"]} = errors_on(changeset)
  end

  test "role_id can't be blank" do
    assert {:error, %Ecto.Changeset{} = changeset} = Accounts.create_user(Map.delete(@valid_attrs, :role_id))
    assert %{role_id: ["can't be blank"]} = errors_on(changeset)
  end

  test "validates uniqueness of user emails" do
    assert {:ok, %Role{} = role} = Accounts.create_role(%{type: "player"})
    assert {:ok, %User{} = user} = Accounts.create_user(%{@valid_attrs | role_id: role.id})
    assert {:error, %Ecto.Changeset{} = changeset} = Accounts.create_user(%{@valid_attrs | role_id: role.id})
    assert %{email: ["has already been taken"]} = errors_on(changeset)
  end
end
