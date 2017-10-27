defmodule Store.Repo.Migrations.CreateMinions do
  use Ecto.Migration

  def change do
    create table(:minions) do
      add :name  , :string, null: false
      add :avatar, :string, null: false

      timestamps()
    end

    create unique_index(:minions, [:name])
  end
end
