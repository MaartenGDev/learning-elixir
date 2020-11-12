defmodule DwaFitnessWeb.CourseController do
  use DwaFitnessWeb, :controller
  alias DwaFitness.{Repo, Category, Course}

  def index(conn, _params) do
    conn
    |> assign(
         :categories,
         Repo.all(Category)
         |> Repo.preload(:courses)
       )
    |> render("index.html")
  end

  def show(conn, %{"id" => id}) do
    render(conn, "show.html", id: id)
  end

  def create(conn, _params) do
    changeset = Course.changeset(%Course{})

    render(conn, "create.html", changeset: changeset)
  end

  def store(conn, %{"course" => course}) do
    changeset = Course.changeset(%Course{}, course)

    case Repo.insert(changeset) do
      {:ok, user} ->
        redirect(conn, to: "/courses")
      {:error, _changeset} ->
        redirect(conn, to: "/courses/create")
    end
  end
end

