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

  def add_weather(args) do
    GenServer.call(__MODULE__, {:add_weather, args})
  end

  #####
  # Server
  ####
  def handle_call({:add_weather, args}, _from, state) do
     # Now we replace this with supervised management
    start_status = Engine.WidgetSupervisor.add_weather(args)
    {:reply, start_status, state}
  end

end
