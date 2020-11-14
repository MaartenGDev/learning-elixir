defmodule DwaFitness.Repo.Migrations.CreateModules do
  use Ecto.Migration

  def change do
    create table(:modules) do
      add :name, :string
      add :course_id, references(:courses)

      timestamps()
    end

  end
end
