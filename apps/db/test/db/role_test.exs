defmodule GifMe.DB.RoleTest do
  use GifMe.DB.DataCase, async: true

  alias GifMe.DB.Repo
  alias GifMe.DB.Accounts
  alias GifMe.DB.Accounts.Role

  test "allows the admin role to be created" do
    assert {:ok, %Role{}} = Accounts.create_role(%{type: "admin"})
  end

  test "allows the player role to be created" do
    assert {:ok, %Role{}} = Accounts.create_role(%{type: "player"})
  end

  test "disallows roles that aren't 'player' or 'admin'" do
    assert {:error, %Ecto.Changeset{} = changeset} = Accounts.create_role(%{type: "janitor"})
    assert %{type: ["is invalid"]} = errors_on(changeset)
  end

  test "type can't be blank" do
    assert {:error, %Ecto.Changeset{} = changeset} = Accounts.create_role(%{type: nil})
    assert %{type: ["can't be blank"]} = errors_on(changeset)
  end

  test "validates uniqueness of type" do
    assert {:ok, %Role{}} = Accounts.create_role(%{type: "admin"})
    assert {:error, %Ecto.Changeset{} = changeset} = Accounts.create_role(%{type: "admin"})
    assert %{type: ["has already been taken"]} = errors_on(changeset)
  end
end
