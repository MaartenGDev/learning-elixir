defmodule DwaFitness.Repo.Migrations.AddCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string
      add :description, :string

      timestamps()
    end
  end
end
