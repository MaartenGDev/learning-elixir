defmodule DwaFitness.Repo.Migrations.CreateVideos do
  use Ecto.Migration

  def change do
    create table(:videos) do
      add :name, :string
      add :url, :string
      add :module_id, references(:modules)

      timestamps()
    end

  end
end
