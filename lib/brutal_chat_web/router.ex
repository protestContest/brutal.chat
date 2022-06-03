defmodule BrutalChatWeb.Router do
  use BrutalChatWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {BrutalChatWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_username
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: BrutalChatWeb.Telemetry
    end
  end

  scope "/", BrutalChatWeb do
    pipe_through :browser

    get "/", PageController, :index
    live "/:room", ChatLive
  end
end
