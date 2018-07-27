defmodule Engine.Server do
  use GenServer
  @moduledoc false

  def start_link(opts) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(args) do
    {:ok, %{
    }}
  end

  # Client
  def add_weather({country, state, city} = location) do
    spec = {Engine.Weather, location}
    GenServer.call(__MODULE__, {:add_widget, spec})
  end

  #####
  # Server
  ####
  def handle_call({:add_widget, spec}, _from, state) do
    start_status = Engine.WidgetSupervisor.add_widget(spec)
    {:reply, start_status, state}
  end

end
