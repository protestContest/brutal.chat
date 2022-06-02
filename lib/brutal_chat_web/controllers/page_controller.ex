defmodule BrutalChatWeb.PageController do
  use BrutalChatWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
