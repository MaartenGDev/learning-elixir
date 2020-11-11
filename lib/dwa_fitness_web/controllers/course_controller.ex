defmodule DwaFitnessWeb.CourseController do
  use DwaFitnessWeb, :controller
  alias DwaFitness.{Repo, Category, Course}

  def index(conn, _params) do
    conn
    |> assign(:categories, Repo.all(Category) |> Repo.preload(:courses))
    |> render("index.html")
  end

  def show(conn, %{"id" => id}) do
    render(conn, "show.html", id: id)
  end
end

