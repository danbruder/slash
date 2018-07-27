defmodule Engine.Weather do
  use GenServer

  def start_link(_args) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(args) do
    Process.send_after(self(), :fetch_weather, 1)

    {:ok,
     %{
       conditions: %{}
     }}
  end

  # 
  # Client
  # 
  def get_weather() do
    GenServer.call(__MODULE__, :get_weather)
  end

  # 
  # Server
  #
  def handle_info(:fetch_weather, state) do
    conditions =  Wunderground.conditions({:us, "MI", "Jamestown"})
    # Get again in 5 minutes
    Process.send_after(self(), :fetch_weather, 1000 * 60 * 5)
    {:noreply, %{conditions: conditions}}
  end

  def handle_call(:get_weather, _from, %{conditions: conditions} = state) do
    {:reply, conditions, state}
  end
end
