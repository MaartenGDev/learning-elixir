defmodule DwaFitnessWeb.CourseController do
  require Logger
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
    invite_code = Ecto.UUID.generate
    course = Repo.get(Course, id)
             |> Repo.preload [modules: [:videos], category: []]

    current_date = DateTime.utc_now();
    formatted_date = "#{current_date.year}/#{current_date.month}/#{current_date.day}";

    changeset = Party.changeset(%Party{}, %{course_id: id, name: "Learning party " <> formatted_date, invite_code: invite_code})
    result = Repo.insert(changeset)

    invite_url = Routes.party_url(conn, :join, invite_code)
    next_module_id = Enum.at(course.modules, 0).id
    next_video_id = Enum.at(Enum.at(course.modules, 0).videos, 0).id

    conn
    |> assign(:course, course)
    |> assign(:invite_code, invite_code)
    |> assign(:invite_url, invite_url)
    |> assign(:next_module_id, next_module_id)
    |> assign(:next_video_id, next_video_id)
    |> render("invite.html")
  end
end

