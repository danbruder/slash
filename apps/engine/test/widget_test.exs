defmodule WidgetTest do
  use ExUnit.Case
  doctest Engine
  alias Engine.Widget

  test "Widget.create/1 returns a widget" do
    title = "Weather"
    type = :weather
    assert {:ok, %Widget{} = widget} = Widget.init(title, type)
    assert widget.title == "Weather"
    assert widget.type == :weather
    assert widget.width == 1
    assert widget.height == 1
  end
end
