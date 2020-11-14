defmodule DwaFitness.Repo.Migrations.AddDescriptionToVideos do
  use Ecto.Migration

  def change do
    alter table(:videos) do
      add :description, :string
    end
  end
end
