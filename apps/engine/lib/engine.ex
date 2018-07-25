defmodule Engine do
  use GenServer
  alias Engine.Grid
  @moduledoc false

  def start_link(opts) do
    GenServer.start_link(__MODULE__, %{}, opts)
  end

  def init(args) do
    {:ok,
     %{
       grid: nil
     }}
  end

  # Client
  def create_grid(engine) do
    GenServer.call(engine, :create_grid)
  end

  def get_grid(engine) do
    GenServer.call(engine, :get_grid)
  end

  # Server
  def handle_call(:create_grid, _from, state) do
    {:reply, {:ok}, Map.put(state, :grid, Grid.init(1500, 600))}
  end

  def handle_call(:get_grid, _from, state) do
    {:reply, state.grid, state}
  end
end
