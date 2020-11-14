defmodule DwaFitness.Module do
  use Ecto.Schema
  import Ecto.Changeset

  schema "modules" do
    field :name, :string

    belongs_to :course, DwaFitness.Course
    has_many :videos, DwaFitness.Video

    timestamps()
  end

  @doc false
  def changeset(module, attrs) do
    module
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
