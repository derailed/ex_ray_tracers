defmodule Store.Repo.Migrations.CreateCastles do
  use Ecto.Migration

  def change do
    create table(:castles) do
      add :name       , :string, null: false
      add :description, :string

      timestamps()
    end

    create unique_index(:castles, [:name])
  end
end
