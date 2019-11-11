defmodule GifMe.DB.User do
  use GifMe.DB.Schema

  @required_fields ~w(nickname email role_id)a

  schema "users" do
    field :nickname, :string
    field :email, :string
    belongs_to :role, GifMe.DB.Role, foreign_key: :role_id

    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:email)
  end
end
