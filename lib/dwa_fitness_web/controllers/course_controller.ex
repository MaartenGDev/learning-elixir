defmodule DwaFitnessWeb.CourseController do
  use DwaFitnessWeb, :controller
  alias DwaFitness.{Repo, Course}

  def index(conn, _params) do
    conn
    |> assign(:courses, Repo.all(Course))
    |> render("index.html")
  end

  def show(conn, %{"id" => id}) do
    render(conn, "show.html", id: id)
  end
end

