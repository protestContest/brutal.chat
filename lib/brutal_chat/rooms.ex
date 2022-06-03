defmodule BrutalChat.Rooms do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def inc(room) do
    GenServer.cast(__MODULE__, {:inc, room})
  end

  def dec(room) do
    GenServer.cast(__MODULE__, {:dec, room})
  end

  def list() do
    GenServer.call(__MODULE__, :list)
  end

  def child_spec(_),
    do: %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, []}
    }

  @impl GenServer
  def init(_opts) do
    {:ok, %{}}
  end

  @impl GenServer
  def handle_cast({:inc, room}, rooms) do
    {:noreply,
     Map.update(rooms, room, 1, fn count ->
       count + 1
     end)}
  end

  @impl GenServer
  def handle_cast({:dec, room}, rooms) do
    {_, rooms} =
      Map.get_and_update(rooms, room, fn
        count when is_integer(count) and count > 1 -> {count, count - 1}
        _ -> :pop
      end)

    {:noreply, rooms}
  end

  @impl GenServer
  def handle_call(:list, _from, rooms) do
    {:reply, rooms, rooms}
  end
end
