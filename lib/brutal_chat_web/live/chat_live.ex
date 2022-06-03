defmodule BrutalChatWeb.ChatLive do
  use BrutalChatWeb, :live_view
  alias BrutalChat.Names
  alias BrutalChat.Rooms
  alias BrutalChatWeb.Endpoint
  alias BrutalChatWeb.Presence
  require Logger

  @default_room "lobby"

  @impl LiveView
  def mount(params, session, socket) do
    %{"room" => room} = params
    %{"username" => username, "user_id" => user_id} = session

    socket =
      socket
      |> assign_new(:id, &UUID.uuid4/0)
      |> assign(:username, username)
      |> assign(:user_id, user_id)
      |> assign(:muted, false)
      |> assign(:default_room, @default_room)
      |> assign(:messages, [])
      |> assign(:events, [create_event("Welcome #{username}")])
      |> assign(:input, nil)
      |> assign(:timeout, nil)
      |> assign(:room, room)
      |> assign(:users, [])

    {:ok, socket}
  end

  @impl LiveView
  def handle_params(%{"room" => room}, _uri, socket) do
    %{assigns: %{room: old_room}} = socket

    {:noreply,
     socket
     |> leave_room(old_room)
     |> join_room(room)
     |> assign(:room, room)
     |> assign(:users, list_users(room))}
  end

  @impl LiveView
  def handle_event("key", _params, %{assigns: %{muted: true}} = socket) do
    {:noreply, socket}
  end

  @impl LiveView
  def handle_event("key", %{"key" => "Enter"}, socket) do
    {:noreply, end_input(socket)}
  end

  @impl LiveView
  def handle_event("key", %{"key" => "Backspace"}, %{assigns: %{input: nil}} = socket) do
    {:noreply, socket}
  end

  @impl LiveView
  def handle_event("key", %{"key" => key, "mod" => false}, socket)
      when byte_size(key) == 1 or key == "Backspace" do
    %{assigns: %{room: room, username: username, input: input}} = socket

    message_id = input || UUID.uuid4()

    Endpoint.broadcast(topic(room), "key", %{
      message_id: message_id,
      key: key,
      author: username
    })

    {:noreply,
     socket
     |> assign(:input, message_id)
     |> reset_timeout()}
  end

  @impl LiveView
  def handle_event("key", _params, socket), do: {:noreply, socket}

  @impl LiveView
  def handle_info(:end_input, socket) do
    {:noreply, end_input(socket)}
  end

  @max_messages 100
  @impl LiveView
  def handle_info(%{event: "key", payload: payload}, socket) do
    %{key: key, message_id: message_id, author: author} = payload
    %{assigns: %{messages: messages}} = socket

    {found, messages} =
      messages
      |> Enum.reduce({false, []}, fn
        %{id: ^message_id} = message, {false, messages} ->
          message = update_message(message, key)
          {true, [message | messages]}

        message, {found, messages} ->
          {found, [message | messages]}
      end)

    messages = if found, do: messages, else: [create_message(message_id, author, key) | messages]

    {:noreply, assign(socket, :messages, Enum.take(messages, @max_messages))}
  end

  @impl LiveView
  def handle_info(%{event: "nick", payload: payload}, socket) do
    %{user_id: id, old: old, new: new} = payload
    %{assigns: %{room: room, user_id: user_id, events: events}} = socket

    Presence.update(self(), topic(room), id, %{username: new})

    socket =
      socket
      |> assign(:users, list_users(room))
      |> assign(:events, [create_event("#{old} is now #{new}") | events])

    if id == user_id do
      {:noreply, assign(socket, :username, new)}
    else
      {:noreply, socket}
    end
  end

  @impl LiveView
  def handle_info(%{event: "presence_diff"}, socket) do
    %{assigns: %{username: username, events: events, room: room, users: old_users}} = socket

    current_users = list_users(room)

    join_events =
      MapSet.new(current_users)
      |> MapSet.difference(MapSet.new(old_users))
      |> MapSet.to_list()
      |> Enum.reject(&(&1 == username))
      |> Enum.map(&create_event("#{&1} joined"))

    leave_events =
      MapSet.new(old_users)
      |> MapSet.difference(MapSet.new(current_users))
      |> MapSet.to_list()
      |> Enum.reject(&(&1 == username))
      |> Enum.map(&create_event("#{&1} left"))

    {:noreply,
     socket
     |> assign(:users, current_users)
     |> assign(:events, join_events ++ leave_events ++ events)}
  end

  @impl LiveView
  def handle_info(%{event: "kick", payload: payload}, socket) do
    %{user: kicked_user} = payload
    %{assigns: %{username: username, events: events}} = socket

    if username == kicked_user do
      {:noreply,
       socket
       |> go_to_room(@default_room, "You were kicked")}
    else
      {:noreply, assign(socket, :events, [create_event("#{kicked_user} was kicked") | events])}
    end
  end

  @impl LiveView
  def handle_info(%{event: "mute", payload: payload}, socket) do
    %{user: muted_user} = payload
    %{assigns: %{username: username, events: events}} = socket

    if username == muted_user do
      {:noreply,
       socket
       |> assign(:muted, true)
       |> assign(:events, [create_event("You were muted") | events])}
    else
      {:noreply, assign(socket, :events, [create_event("#{muted_user} was muted") | events])}
    end
  end

  @impl LiveView
  def terminate(_reason, socket) do
    %{assigns: %{room: room, user_id: user_id}} = socket
    Presence.untrack(self(), topic(room), user_id)
  end

  @impl LiveView
  def render(assigns) do
    ~H"""
    <div id="chat" class="chat" phx-hook="ScrollDown" onclick="refocus()">
      <%= if @room != @default_room do %>
        <.title title={@room} />
      <% end %>
      <%= for item <- chat_items(@messages, @events) do %>
        <%= if item.type == :event do %>
          <.event event={item} />
        <% else %>
          <.message message={item} self={item.author == @username} active={item.id == @input} />
        <% end %>
      <% end %>
      <.user_list users={@users} />
      <input phx-keydown="key" id="input" class="input" autofocus autocomplete="off" autocorrect="off" autocapitalize="off" />
    </div>
    """
  end

  defp chat_items(messages, events) do
    (messages ++ events)
    |> Enum.sort(fn %{dt: dt1}, %{dt: dt2} -> DateTime.compare(dt1, dt2) != :gt end)
  end

  defp title(assigns) do
    ~H"""
    <div class="title"><%= @title %></div>
    """
  end

  defp event(assigns) do
    ~H"""
    <div class="event-box">
      &mdash; <%= @event.content %> &mdash;
    </div>
    """
  end

  defp message(assigns) do
    ~H"""
    <div id={@message.id} class={["message", (if @active, do: "active"), (if @self, do: "self")]} phx-hook="ResetBorder">
      <div class="box">
        <span class="title"><%= @message.author %></span>
        <%= @message.content %>
      </div>
    </div>
    """
  end

  defp user_list(assigns) do
    ~H"""
    <div class="user-list">
      <div class="title" onmouseover="show('.user-list .content')" onmouseleave="hide('.user-list .content')">
        <%= if Enum.count(@users) > 1  do %>
          <%= Enum.count(@users) %> here
        <% else %>
          No one here
        <% end %>
      </div>
      <div class="content" style="display: none">
        <%= for user <- @users do %>
          <div><%= user %></div>
        <% end %>
      </div>
    </div>
    """
  end

  defp topic(room), do: "events:#{room}"

  defp create_event(content), do: %{type: :event, dt: DateTime.utc_now(), content: content}

  defp create_message(id, author, content),
    do: %{id: id, type: :message, author: author, content: content, dt: DateTime.utc_now()}

  defp parse_command(socket) do
    %{assigns: %{messages: messages}} = socket

    with %{content: content} <- Enum.find(messages, &(&1.id == socket.assigns.input)),
         [_, command, arg] <- Regex.run(~r"^/([[:alpha:]]+) ?(.*)$", content) do
      arg = String.trim(arg)

      case command do
        "nick" -> change_username(socket)
        "join" -> go_to_room(socket, arg, "Welcome to #{arg}")
        "leave" -> go_to_room(socket, @default_room, "Welcome back")
        "rooms" -> list_rooms(socket)
        "kick" -> kick_user(socket, arg)
        "mute" -> mute_user(socket, arg)
        _ -> socket
      end
    else
      _ -> socket
    end
  end

  defp change_username(socket) do
    %{assigns: %{room: room, username: old_username, user_id: user_id}} = socket
    {offset, new_username} = Names.new_username(user_id)
    Endpoint.broadcast(topic(room), "nick", %{user_id: user_id, old: old_username, new: new_username})

    assign(socket, :username, new_username)
    |> push_event("store", %{key: user_id, value: offset})
  end

  defp go_to_room(socket, room, welcome) do
    %{assigns: %{events: events}} = socket

    socket
    |> assign(:events, [create_event(welcome) | events])
    |> push_patch(to: "/#{room}")
  end

  defp join_room(socket, room) do
    if connected?(socket) do
      %{assigns: %{user_id: user_id, username: username}} = socket
      Endpoint.subscribe(topic(room))

      if not in_room?(username, room) do
        Rooms.inc(room)
      end

      username =
        if in_room?(username, room) do
          Presence.get_by_key(topic(room), user_id)
          |> Map.get(:metas)
          |> List.first()
          |> Map.get(:username)
        else
          username
        end

      Presence.track(self(), topic(room), user_id, %{
        username: username,
        joined_at: DateTime.utc_now()
      })

      assign(socket, :username, username)
    else
      socket
    end
  end

  defp leave_room(socket, room) do
    if connected?(socket) do
      %{assigns: %{user_id: user_id, username: username}} = socket
      Endpoint.unsubscribe(topic(room))
      Presence.untrack(self(), topic(room), user_id)

      if not in_room?(username, room) do
        Rooms.dec(room)
      end
    end

    socket
  end

  defp in_room?(username, room) do
    find_in_room(username, room) != nil
  end

  defp find_in_room(username, room) do
    Presence.list(topic(room))
    |> Enum.find_value(fn {id, %{metas: [meta | _]}} ->
      if meta.username == username, do: id
    end)
  end

  defp list_rooms(socket) do
    %{assigns: %{events: events}} = socket

    rooms =
      Rooms.list()
      |> Enum.reject(fn {room, _} -> room == @default_room end)
      |> Enum.map(fn {room, count} -> "#{room} (#{count})" end)

    message =
      if Enum.count(rooms) == 0 do
        "No rooms yet"
      else
        "Rooms: #{Enum.join(rooms, ", ")}"
      end

    assign(socket, :events, [create_event(message) | events])
  end

  defp kick_user(socket, username) do
    %{assigns: %{room: room}} = socket

    if(in_room?(username, room)) do
      Endpoint.broadcast(topic(room), "kick", %{user: username})
    end

    socket
  end

  defp mute_user(socket, username) do
    %{assigns: %{room: room}} = socket
    Endpoint.broadcast(topic(room), "mute", %{user: username})
    socket
  end

  @message_timeout 3000
  defp reset_timeout(socket) do
    if socket.assigns.timeout != nil do
      Process.cancel_timer(socket.assigns.timeout)
    end

    timeout = Process.send_after(self(), :end_input, @message_timeout)
    assign(socket, :timeout, timeout)
  end

  defp end_input(socket) do
    if socket.assigns.timeout != nil do
      Process.cancel_timer(socket.assigns.timeout)
    end

    socket
    |> parse_command()
    |> assign(:timeout, nil)
    |> assign(:input, nil)
    |> assign(:messages, Enum.filter(socket.assigns.messages, &(String.length(&1.content) > 0)))
  end

  defp update_message(message, "Backspace") do
    Map.update(message, :content, "", &String.slice(&1, 0..-2//1))
  end

  defp update_message(message, key) do
    Map.update(message, :content, key, &(&1 <> key))
  end

  defp list_users(room) do
    Presence.list(topic(room))
    |> Enum.map(fn {_id, %{metas: metas}} ->
      List.first(metas)
      |> Map.get(:username)
    end)
  end
end
