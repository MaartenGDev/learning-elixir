defmodule DwaFitnessWeb.PartyController do
  use DwaFitnessWeb, :controller
  alias DwaFitness.{Repo, Category, Course}

  def join(conn, %{"invite_code" => invite_code}) do
    redirect(conn, to: "/courses")
  end
end

