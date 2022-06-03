defmodule BrutalChatWeb.Plugs do
  import Plug.Conn
  alias BrutalChat.Names
  alias BrutalChat.Hash
  require Logger

  def fetch_username(conn, _opts \\ []) do
    conn = fetch_cookies(conn)

    %{id: user_id, offset: offset} = get_user_info(conn)
    username = Names.hash_username("#{user_id}:#{offset}")

    conn
    |> put_session(:username, username)
    |> put_session(:user_id, user_id)
  end

  defp get_user_info(conn) do
    id = ip_hash(get_ip(conn))
    offset = Map.get(conn.cookies, id, "0")
    %{id: id, offset: offset}
  end

  defp ip_hash(ip) do
    Hash.fnv(ip)
    |> Integer.to_string(16)
    |> String.slice(0..15)
  end

  defp get_ip(conn) do
    forwarded_for =
      conn
      |> get_req_header("x-forwarded-for")
      |> List.first()

    if forwarded_for do
      forwarded_for
      |> String.split(",")
      |> Enum.map(&String.trim/1)
      |> List.last()
    else
      conn.remote_ip
      |> Tuple.to_list()
      |> Enum.join(".")
    end
  end
end
