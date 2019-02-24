defmodule ReadingLists.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :list_id, references(:lists, type: :binary_id, on_delete: :delete_all), null: false
      add :url, :string, null: false
      add :title, :string
      add :is_starred, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end

  end
end
