defmodule GifMe.DB.Accounts.Role do
  use GifMe.DB.Schema

  @role_types ~w(player admin)

  @required_fields ~w(type)a

  schema "roles" do
    field(:type, :string)
    has_many(:users, GifMe.DB.Accounts.User)
  end

  def changeset(role, params \\ %{}) do
    role
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> validate_inclusion(:type, @role_types)
    |> unique_constraint(:type)
  end
end
