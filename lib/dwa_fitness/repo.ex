defmodule DwaFitness.Repo do
  use Ecto.Repo,
    otp_app: :dwa_fitness,
    adapter: Ecto.Adapters.Postgres
end
