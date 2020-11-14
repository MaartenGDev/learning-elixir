defmodule DwaFitness.Repo.Migrations.AddDurationToVideos do
  use Ecto.Migration

  def change do
    alter table(:videos) do
      add :duration_in_minutes, :integer
    end
  end
end
