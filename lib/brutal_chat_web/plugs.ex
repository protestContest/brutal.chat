defmodule BrutalChatWeb.Plugs do
  import Plug.Conn
  alias BrutalChat.Names
  alias BrutalChat.Hash

  def fetch_username(conn, _opts \\ []) do
    conn = fetch_cookies(conn)

    %{id: user_id, offset: offset} = get_user_info(conn)
    username = Names.hash_username("#{user_id}:#{offset}")

    conn
    |> put_session(:username, username)
    |> put_session(:user_id, user_id)
  end

  defp get_user_info(conn) do
    id = ip_hash(conn.remote_ip)
    offset = Map.get(conn.cookies, id, "0")
    %{id: id, offset: offset}
  end

  defp ip_hash({a, b, c, d}) do
    Hash.fnv("#{a}.#{b}.#{c}.#{d}")
    |> Integer.to_string(16)
    |> String.slice(0..15)
  end
end
