defmodule DwaFitness.Repo.Migrations.AddVideoUrlToCourse do
  use Ecto.Migration

  def change do
    alter table(:courses) do
      add :video_url, :string
    end
  end
end
