defmodule BrutalChatWeb.PageController do
  use BrutalChatWeb, :controller

  def index(conn, _params) do
    conn
    |> put_view(BrutalChatWeb.PageView)
    |> put_layout(html: {BrutalChatWeb.LayoutView, :app})
    |> render(:index)
  end

  def deny(conn, _params) do
    send_resp(conn, :not_found, "")
  end
end
