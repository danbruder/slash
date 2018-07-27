defmodule EngineTest do
  use ExUnit.Case, async: true
  doctest Engine
  alias Engine.Grid
  @valid_location {:us, "MI", "Hudsonville"}
  @international_location {:international, "CA", "Toronto"}
  @invalid_location {:us, "MI", "Invalid"}

  setup do
    :ok
  end

  test "Engine.Server.add_weather/1 adds a widget" do
    {:ok, pid} = Engine.Server.add_weather(@valid_location)
    {:ok, %{location: location}} = Engine.Weather.get(pid)
    assert location == @valid_location
  end

  test "Engine.Server.add_weather/1 handles international locations " do
    assert {:error, {:not_supported, message}} =
             Engine.Server.add_weather(@international_location)
  end

  test "Engine.Server.add_weather/1 returns an error if the location is invalid" do
    assert {:error, {:not_found, error_message}} = Engine.Server.add_weather(@invalid_location)
  end
end
