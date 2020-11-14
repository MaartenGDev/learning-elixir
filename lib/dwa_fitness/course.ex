defmodule DwaFitness.Course do
  use Ecto.Schema
  import Ecto.Changeset

  schema "courses" do
    field :name, :string
    field :description, :string
    field :image_url, :string
    field :video_url, :string
    belongs_to :category, DwaFitness.Category

    timestamps()
  end

  @doc false
  def changeset(course, attrs \\ %{}) do
    course
    |> cast(attrs, [:name, :description, :image_url, :video_url])
    |> validate_required([:name, :description, :image_url, :video_url])
  end
end
