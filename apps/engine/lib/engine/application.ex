defmodule Engine.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  def foo do
    IO.puts "foo called"
  end

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: Engine.Worker.start_link(arg)
      Engine.Weather
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Engine.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
