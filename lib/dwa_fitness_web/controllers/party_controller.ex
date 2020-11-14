defmodule DwaFitnessWeb.PartyController do
  use DwaFitnessWeb, :controller
  alias DwaFitness.{Repo, Category, Course}

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
    invite_url = Routes.course_path(@conn, :invite, id)

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

