defmodule GifMe.DB.Repo.Migrations.CreatePrompts do
  use Ecto.Migration

  def change do
    create table(:prompts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :type, :string, unique: true
      add :source, :string
      add :url, :string
    end

    create unique_index(:prompts, [:url])
  end
end
