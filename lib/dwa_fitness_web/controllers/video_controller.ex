defmodule DwaFitnessWeb.VideoController do
  use DwaFitnessWeb, :controller
  alias DwaFitness.{Repo, Course, Video}

  def show(conn, %{"course_id" => course_id, "module_id" => module_id_param, "video_id" => video_id}) do
    {module_id, ""} = Integer.parse(module_id_param)

    course = Repo.get(Course, course_id)
                   |> Repo.preload [modules: [:videos], category: []]


    conn
    |> assign(
         :video,
         Repo.get(Video, video_id)
         |> Repo.preload [
           module: [
             course: [:category]
           ]
         ]
       )
    |> assign(:course, course)
    |> assign(:module_id, module_id)
    |> render("show.html")
  end
end

