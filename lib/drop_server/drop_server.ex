defmodule DropServer.Worker do
  use GenServer

  defmodule State do
    defstruct count: 0
  end

  #This is a convenience method for startup
  def start_link(_) do
      GenServer.start_link(__MODULE__, [], [{:name, __MODULE__}])
  end

  #These are the callbacks that Genserver.behaviour will call
  def init([]) do
      {:ok, %State{}}
  end

  def handle_call(request, _from, state) do
      distance = request
      reply = {"ok", fall_velocity(distance)}
      new_state = %State{count: state.count + 1}
      {:reply, reply, new_state}
  end

  def handle_cast(_msg, state) do
      IO.puts("So far calculated #{state.count} velocities.")
      {:noreply, state}
  end

  def handle_info(_info, state) do
      {:noreply, state}
  end

  def terminate(_reason, _state) do
      {:ok}
  end

  def code_change(_old_version, state, _extra) do
      {:ok, state}
  end

  #internal function
  def fall_velocity(distance) do
      :math.sqrt(2 * 9.8 * distance)
  end

  #api

  def calculate_drop(h) do
      GenServer.call(__MODULE__, h)
  end

  def how_many_calls do
      GenServer.cast(__MODULE__, nil)
  end

end