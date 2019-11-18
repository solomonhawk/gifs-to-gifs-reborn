defmodule GifMe.DB.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :type, :string, unique: true
    end

    create unique_index(:roles, [:type])

    alter table(:users) do
      add :role_id, references(:roles, type: :binary_id), null: false
    end
  end
end
