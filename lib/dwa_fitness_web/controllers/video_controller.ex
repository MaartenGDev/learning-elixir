defmodule DwaFitnessWeb.VideoController do
  use DwaFitnessWeb, :controller
  alias DwaFitness.{Repo, Video}

  def show(conn, %{"id" => id}) do
    conn
    |> assign(
         :video,
         Repo.get(Video, id)
             |> Repo.preload [module: [course: [:category]]]
       )
    |> render("show.html")
  end
end

