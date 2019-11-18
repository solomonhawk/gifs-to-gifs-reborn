defmodule GifMe.DB.Accounts.User do
  use GifMe.DB.Schema

  import Bcrypt, only: [add_hash: 1]

  alias GifMe.DB.Accounts

  @required_fields ~w(nickname email password role_id)a
  @fields [id: "id", nickname: "name"]

  schema "users" do
    field(:nickname, :string)
    field(:email, :string)
    field(:password, :string, virtual: true)
    field(:password_hash, :string)
    belongs_to(:role, GifMe.DB.Accounts.Role, foreign_key: :role_id)

    timestamps()
  end

  # TODO(shawk): break apart registration_changeset and update_changeset (?)
  def changeset(user, params \\ %{}) do
    user
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:nickname, min: 3)
    |> validate_length(:password, min: 6)
    |> unique_constraint(:email)
    |> put_password_hash()
    |> validate_confirmation(:password, message: "does not match password")
  end

  def fields, do: @fields

  def with_computed_fields(nil), do: nil

  def with_computed_fields(user) do
    Map.put(user, :is_admin?, Accounts.is_admin?(user))
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: pass}} = changeset) do
    change(changeset, add_hash(pass))
  end

  defp put_password_hash(changeset), do: changeset
end
