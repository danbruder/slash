defmodule GridTest do
  use ExUnit.Case
  doctest Engine
  alias Engine.Grid

  test "Engine.Grid.init/2 initializes a grid based on width and height" do
    assert {:ok, %Grid{} = grid} = Grid.init(1500, 600)
    assert grid.px_width == 1500
    assert grid.px_height == 600
    assert grid.width == 5
    assert grid.height == 3
    assert grid.px_spot_width == 300
    assert grid.px_spot_height == 200
  end

end
