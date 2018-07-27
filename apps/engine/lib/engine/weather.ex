defmodule Engine.Weather do
  use GenServer

  def init({:us, city, state} = location) do
    case Wunderground.conditions(location) do
      {:error, {:not_found, message}} = error ->
        {:stop, {:not_found, message}}

      {:ok, nil} ->
        {:stop, {:not_found, ""}}

      {:ok, conditions} ->
        Process.send_after(self(), :fetch_weather, 1)
        {:ok, %{conditions: conditions, location: location}}
    end
  end

  def init(_location) do
    {:stop, {:not_supported, "Only US is supported"}}
  end

  def start_link([], location) do
    start_link(location)
  end

  def start_link({:us, state, city} = location) do
    GenServer.start_link(__MODULE__, location, name: {:global, "weather:us#{state}#{city}"})
  end

  def start_link({:international, country, city} = location) do
    GenServer.start_link(
      __MODULE__,
      location,
      name: {:global, "weather:international#{country}#{city}"}
    )
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
  def handle_info(:fetch_weather, %{location: location} = state) do
    conditions = Wunderground.conditions(location)
    # Get again in 5 minutes
    Process.send_after(self(), :fetch_weather, 1000 * 60 * 5)
    {:noreply, Map.put(state, :conditions, conditions)}
  end

  def handle_call(:get, _from, state) do
    {:reply, {:ok, state}, state}
  end
end
