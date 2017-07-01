defmodule EchoWorld do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, args) do
    import Supervisor.Spec, warn: false

    IO.inspect args
    children = [
      # Define workers and child supervisors to be supervised
      worker(EchoWorld.Worker, args)
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EchoWorld.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
