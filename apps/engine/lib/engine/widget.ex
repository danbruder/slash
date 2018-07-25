defmodule Engine.Widget do
  @moduledoc false
  alias __MODULE__
  defstruct [:title, :type, :width, :height]

  def init(title, type) do
    {:ok, %Widget{title: title, type: type, width: 1, height: 1}}
  end
end
