defmodule DwaFitness.Repo.Migrations.CourseBelongsToCategory do
  use Ecto.Migration

  def change do
    alter table(:courses) do
      add :category_id, references(:categories)
    end
  end
end
