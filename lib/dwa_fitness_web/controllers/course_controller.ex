defmodule DwaFitnessWeb.CourseController do
  use DwaFitnessWeb, :controller
  alias DwaFitness.{Repo, Category, Course, Party}

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
    conn
    |> assign(
         :course,
         Repo.get(Course, id)
         |> Repo.preload [modules: [:videos], category: []]
       )
    |> render("show.html")
  end

  def create(conn, _params) do
    changeset = Course.changeset(%Course{})

    render(conn, "create.html", changeset: changeset)
  end

  def store(conn, %{"course" => course}) do
    changeset = Course.changeset(%Course{}, course)

    case Repo.insert(changeset) do
      {:ok, _user} ->
        redirect(conn, to: "/courses")
      {:error, _changeset} ->
        redirect(conn, to: "/courses/create")
    end
  end

  def invite(conn, %{"id" => id}) do
    invite_code = "aaa-bbb-ccc"
    changeset = Party.changeset(%Party{}, %{name: "test", invite_code: invite_code})

    invite_url = Routes.party_url(conn, :join, invite_code)

    conn
    |> assign(
         :course,
         Repo.get(Course, id)
         |> Repo.preload(:category)
       )
    |> assign(:invite_url, invite_url)
    |> render("invite.html")
  end
end

