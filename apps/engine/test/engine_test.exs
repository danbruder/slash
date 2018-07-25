defmodule EngineTest do
  use ExUnit.Case, async: true
  doctest Engine
  alias Engine.Grid

  setup do
    engine = start_supervised!(Engine)
    %{engine: engine}
  end

  test "Engine.create_grid/1 creates a new grid", %{engine: engine} do
    Engine.create_grid(engine)
    assert {:ok, grid} = Engine.get_grid(engine)
    assert grid.width == 5
  end

  test "Engine.add_widget/1 with valid coordinates adds a widget to the grid" do
    # widget = Widget.new("Weather", :weather)
    # Engine.add_widget(weather, 1, 1)
  end
end
