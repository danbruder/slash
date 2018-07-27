defmodule Engine.Weather do
  use GenServer

  def init(location) do
    Process.send_after(self(), :fetch_weather, 1)

    {:ok,
     %{
       conditions: %{},
       location: location
     }}
  end

  def start_link([], location) do
    start_link(location)
  end

  def start_link({country, state, city} = location) do
    GenServer.start_link(__MODULE__, location, name: {:global, "weather:#{state}#{city}"})
  end

  # 
  # Client
  # 
  def get(pid) do
    GenServer.call(pid, :get)
  end

  # 
  # Server
  #
  def handle_info(:fetch_weather, %{location:  location} = state) do
    conditions =  Wunderground.conditions(location)
    # Get again in 5 minutes
    Process.send_after(self(), :fetch_weather, 1000 * 60 * 5)
    {:noreply, Map.put(state, :conditions,  conditions)}
  end

  def handle_call(:get, _from, state) do
    {:reply, {:ok, state}, state}
  end
end
