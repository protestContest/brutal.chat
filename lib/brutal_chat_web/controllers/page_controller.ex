defmodule BrutalChatWeb.PageController do
  use BrutalChatWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def deny(conn, _params) do
    send_resp(conn, :not_found, "")
  end
end
