defmodule DwaFitness.Repo.Migrations.CreateCourses do
  use Ecto.Migration

  def change do
    create table(:courses) do
      add :name, :string
      add :description, :string
      add :image_url, :string

      timestamps()
    end

  end
end
