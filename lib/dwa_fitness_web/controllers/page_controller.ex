defmodule DwaFitnessWeb.PageController do
  use DwaFitnessWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
