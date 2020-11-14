defmodule DwaFitness.Party do
  use Ecto.Schema
  import Ecto.Changeset

  schema "parties" do
    field :name, :string
    field :invite_code, :string
    belongs_to :course, DwaFitness.Course

    timestamps()
  end

  @doc false
  def changeset(party, attrs) do
    party
    |> cast(attrs, [:name, :invite_code, :course_id])
    |> validate_required([:name, :invite_code, :course_id])
  end
end
