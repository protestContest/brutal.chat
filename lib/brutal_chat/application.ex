defmodule BrutalChat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      BrutalChatWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: BrutalChat.PubSub},
      # Start the Endpoint (http/https)
      BrutalChatWeb.Endpoint
      # Start a worker by calling: BrutalChat.Worker.start_link(arg)
      # {BrutalChat.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BrutalChat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BrutalChatWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
