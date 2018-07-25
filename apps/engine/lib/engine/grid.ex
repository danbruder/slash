defmodule Engine.Grid do
  @moduledoc false
  defstruct [:px_width, :px_height, :width, :height, :px_spot_width, :px_spot_height]

  alias __MODULE__

  def init(width, height) do
    {:ok,
     %Grid{
       px_width: width,
       px_height: height,
       px_spot_width: 300,
       px_spot_height: 200,
       width: 5,
       height: 3
     }}
  end
end
