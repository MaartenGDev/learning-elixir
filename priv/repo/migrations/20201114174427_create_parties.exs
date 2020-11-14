defmodule DwaFitness.Repo.Migrations.CreateParties do
  use Ecto.Migration

  def change do
    create table(:parties) do
      add :name, :string
      add :invite_code, :string
      add :course_id, references(:courses)


      timestamps()
    end

  end
end
