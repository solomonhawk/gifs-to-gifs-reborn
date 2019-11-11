defmodule GifMe.DB.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :nickname, :string
      add :email, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
