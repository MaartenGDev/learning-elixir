defmodule DwaFitness.Video do
  use Ecto.Schema
  import Ecto.Changeset

  schema "videos" do
    field :name, :string
    field :description, :string
    field :url, :string
    field :duration_in_minutes, :integer

    belongs_to :module, DwaFitness.Module

    timestamps()
  end

  @doc false
  def changeset(video, attrs) do
    video
    |> cast(attrs, [:name, :description, :url, :duration_in_minutes])
    |> validate_required([:name, :description, :url, :duration_in_minutes])
  end
end
