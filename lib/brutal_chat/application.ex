defmodule BrutalChat.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BrutalChatWeb.Telemetry,
      {Phoenix.PubSub, name: BrutalChat.PubSub},
      BrutalChatWeb.Endpoint,
      BrutalChatWeb.Presence
    ]

    opts = [strategy: :one_for_one, name: BrutalChat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    BrutalChatWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
