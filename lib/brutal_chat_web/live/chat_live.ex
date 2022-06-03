defmodule BrutalChatWeb.ChatLive do
  use BrutalChatWeb, :live_view
  alias BrutalChat.Names
  alias BrutalChatWeb.Endpoint
  alias BrutalChatWeb.Presence

  @default_room "lobby"

  defp topic(room), do: "events:#{room}"

  def mount(%{"room" => room}, %{"username" => username, "user_id" => user_id}, socket) do
    IO.inspect(Presence.list("rooms"), label: "Rooms")

    if connected?(socket) do
      Endpoint.subscribe(topic(room))

      already_here? = Presence.get_by_key(topic(room), user_id) != []

      if not already_here? do
        Presence.track(self(), topic(room), user_id, %{
          username: username,
          joined_at: DateTime.utc_now()
        })

        if Presence.list("rooms") == %{} do
          Presence.track(self(), "rooms", room, %{})
          |> IO.inspect()
        else
          Presence.update(self(), "rooms", room, fn meta -> IO.inspect(meta) end)
        end
      end
    end

    socket =
      socket
      |> assign_new(:id, &UUID.uuid4/0)
      |> assign(:username, username)
      |> assign(:user_id, user_id)
      |> assign(:room, room)
      |> assign(:default_room, @default_room)
      |> assign(:messages, [])
      |> assign(:events, [create_event("Welcome #{username}")])
      |> assign(:input, nil)
      |> assign(:timeout, nil)
      |> assign(:users, list_users(room))

    {:ok, socket}
  end

  defp create_event(content), do: %{type: :event, dt: DateTime.utc_now(), content: content}

  defp create_message(id, author, content),
    do: %{id: id, type: :message, author: author, content: content, dt: DateTime.utc_now()}

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

  def title(assigns) do
    ~H"""
    <div class="title"><%= @title %></div>
    """
  end

  def event(assigns) do
    ~H"""
    <div class="event-box">
      &mdash; <%= @event.content %> &mdash;
    </div>
    """
  end

  def message(assigns) do
    ~H"""
    <div id={@message.id} class={message_class(@self, @active)} phx-hook="ResetBorder">
      <div class="box">
        <span class="title"><%= @message.author %></span>
        <%= @message.content %>
      </div>
    </div>
    """
  end

  defp message_class(self, active) do
    self_class = if self, do: "self", else: ""
    active_class = if active, do: "active", else: ""

    Enum.join(["message", self_class, active_class], " ")
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

  def handle_event("key", %{"key" => "Enter"}, socket) do
    {:noreply, end_input(socket)}
  end

  def handle_event("key", %{"key" => "Backspace"}, %{assigns: %{input: nil}} = socket), do: {:noreply, socket}

  def handle_event("key", %{"key" => key, "mod" => false}, %{assigns: assigns} = socket)
      when byte_size(key) == 1 or key == "Backspace" do
    message_id = assigns.input || UUID.uuid4()

    Endpoint.broadcast(topic(assigns.room), "key", %{
      message_id: message_id,
      key: key,
      author: assigns.username
    })

    {:noreply,
     socket
     |> assign(:input, message_id)
     |> reset_timeout()}
  end

  def handle_event("key", _params, socket), do: {:noreply, socket}

  defp parse_command(%{assigns: %{messages: messages}} = socket) do
    with %{content: content} <- Enum.find(messages, &(&1.id == socket.assigns.input)),
         [_, command, arg] <- Regex.run(~r"^/([[:alpha:]]+) ?(.*)$", content) do
      arg = String.trim(arg)

      case command do
        "nick" -> change_username(socket)
        "join" -> join_room(arg, socket)
        "leave" -> join_room(@default_room, socket)
        _ -> socket
      end
    else
      _ -> socket
    end
  end

  @max_offset 1_000_000_000_000
  defp change_username(%{assigns: %{room: room, username: old_username, user_id: user_id}} = socket) do
    offset = :rand.uniform(@max_offset)
    new_username = Names.hash_username("#{user_id}:#{offset}")
    Endpoint.broadcast(topic(room), "nick", %{user_id: user_id, old: old_username, new: new_username})

    assign(socket, :username, new_username)
    |> push_event("store", %{key: user_id, value: offset})
  end

  defp join_room(new_room, socket) do
    %{assigns: %{room: old_room, events: events}} = socket
    Endpoint.unsubscribe(topic(old_room))
    Endpoint.subscribe(topic(new_room))

    message = if new_room == @default_room, do: "Welcome back", else: "Welcome to #{new_room}"

    socket
    |> assign(:room, new_room)
    |> assign(:events, [create_event(message) | events])
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

  def handle_info(:end_input, socket) do
    {:noreply, end_input(socket)}
  end

  @max_messages 100
  def handle_info(%{event: "key", payload: %{key: key, message_id: message_id, author: author}}, socket) do
    {found, messages} =
      socket.assigns.messages
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

  def handle_info(%{event: "nick", payload: %{user_id: id, old: old, new: new}}, socket) do
    %{assigns: %{room: room, user_id: user_id, events: events}} = socket
    Presence.update(self(), topic(room), user_id, %{username: new})

    socket =
      socket
      |> assign(:users, list_users(room))
      |> assign(:events, [create_event("#{old} is now #{new}") | events])

    socket =
      if id == user_id do
        assign(socket, :username, new)
      else
        socket
      end

    {:noreply, socket}
  end

  def handle_info(%{event: "presence_diff"}, socket) do
    %{assigns: %{username: username, events: events, room: room, users: old_users}} = socket
    current_users = list_users(room)

    joins =
      MapSet.new(current_users)
      |> MapSet.difference(MapSet.new(old_users))
      |> MapSet.to_list()

    leaves =
      MapSet.new(old_users)
      |> MapSet.difference(MapSet.new(current_users))
      |> MapSet.to_list()

    join_events =
      joins
      |> Enum.reject(&(&1 == username))
      |> Enum.map(&create_event("#{&1} joined"))

    leave_events =
      leaves
      |> Enum.reject(&(&1 == username))
      |> Enum.map(&create_event("#{&1} left"))

    socket =
      socket
      |> assign(:users, current_users)
      |> assign(:events, join_events ++ leave_events ++ events)

    {:noreply, socket}
  end

  def update_message(message, "Backspace") do
    Map.update(message, :content, "", &String.slice(&1, 0..-2//1))
  end

  def update_message(message, key) do
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
