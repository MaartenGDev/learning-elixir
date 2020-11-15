defmodule DwaFitnessWeb.PartyChannel do
  require Logger
  use Phoenix.Channel

  def join("learning-party:" <> party_id, payload, socket) do
    {:ok, socket}
  end

  def handle_in("learning-party:" <> party_id, payload, socket) do
    broadcast! socket, "learning-party:" <> party_id, payload
    {:noreply, socket}
  end
end