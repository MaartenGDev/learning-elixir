defmodule DwaFitnessWeb.PartyController do
  use DwaFitnessWeb, :controller
  alias DwaFitness.{Repo, Category, Party}

  def join(conn, %{"invite_code" => invite_code}) do
    party = Repo.get_by(Party, invite_code: invite_code)
      |> Repo.preload(:course)

    conn
    |> assign(:party, party)
    |> assign(:invite_code, invite_code)
    |> render("join.html")
  end
end

