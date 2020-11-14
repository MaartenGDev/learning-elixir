defmodule DwaFitness.Repo.Migrations.MoveCourseVideoUrlToVideos do
  use Ecto.Migration

  def change do
    alter table(:courses) do
      remove :video_url
    end
  end
end
