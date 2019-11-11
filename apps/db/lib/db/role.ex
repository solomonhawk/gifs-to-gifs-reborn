defmodule GifMe.DB.Role do
  use GifMe.DB.Schema

  @role_types ~w(user admin)

  @required_fields ~w(type)a

  schema "roles" do
    field :type, :string
    has_many :users, GifMe.DB.User
  end

  def changeset(role, params \\ %{}) do
    role
    |> cast(params, @required_fields)
    |> validate_inclusion(:type, @role_types)
    |> unique_constraint(:type)
  end
end
