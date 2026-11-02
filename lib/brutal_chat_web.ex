defmodule BrutalChatWeb do
  def controller do
    quote do
      use Phoenix.Controller, formats: [:html]

      import Plug.Conn
    end
  end

  def static_paths, do: ~w(assets fonts images favicon.ico robots.txt)

  def html do
    quote do
      use Phoenix.Component

      import Phoenix.Controller, only: [get_csrf_token: 0]
      import Phoenix.HTML

      use Phoenix.VerifiedRoutes,
        endpoint: BrutalChatWeb.Endpoint,
        router: BrutalChatWeb.Router,
        statics: BrutalChatWeb.static_paths()
    end
  end

  def live_view do
    quote do
      use Phoenix.LiveView,
        layout: {BrutalChatWeb.LayoutView, :live}

      alias Phoenix.LiveView
      alias Phoenix.LiveView.JS
    end
  end

  def live_component do
    quote do
      use Phoenix.LiveComponent
    end
  end

  def component do
    quote do
      use Phoenix.Component
    end
  end

  def router do
    quote do
      use Phoenix.Router

      import Plug.Conn
      import Phoenix.Controller
      import Phoenix.LiveView.Router
      import BrutalChatWeb.Plugs
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
