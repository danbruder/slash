defmodule Engine.WidgetSupervisor do
  use DynamicSupervisor

  def start_link(_arg) do
    DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  # Start a widget process and add it to supervision
  def add_weather(location) do
    # Note that start_child now directly takes in a child_spec.
    child_spec = {Engine.Weather, location}
    # Equivalent to:
    # child_spec = widget.child_spec({widget_name, game_id})
    DynamicSupervisor.start_child(__MODULE__, child_spec)
  end

  # Terminate a widget process and remove it from supervision
  def remove_widget(widget_pid) do
    DynamicSupervisor.terminate_child(__MODULE__, widget_pid)
  end

  # Nice utility method to check which processes are under supervision
  def children do
    DynamicSupervisor.which_children(__MODULE__)
  end

  # Nice utility method to check which processes are under supervision
  def count_children do
    DynamicSupervisor.count_children(__MODULE__)
  end
end
