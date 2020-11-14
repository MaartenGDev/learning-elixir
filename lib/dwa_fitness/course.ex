defmodule DwaFitness.Course do
  use Ecto.Schema
  import Ecto.Changeset

  schema "courses" do
    field :name, :string
    field :description, :string
    field :image_url, :string

    belongs_to :category, DwaFitness.Category
    has_many :modules, DwaFitness.Module

    timestamps()
  end

  @doc false
  def changeset(course, attrs \\ %{}) do
    course
    |> cast(attrs, [:name, :description, :image_url])
    |> validate_required([:name, :description, :image_url])
  end
end
