defmodule ReadingLists.Repo.Migrations.CreateLists do
  use Ecto.Migration

  def change do
    create table(:lists, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string, null: false
      add :is_starred, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end

  end
end
