defmodule AmqpSandbox.Mixfile do
  use Mix.Project

  def project do
    [app: :amqp_sandbox,
     version: "0.0.1",
     elixir: "~> 0.13.2-dev",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:amqp],
     mod: {AmqpSandbox, []}]
  end

  # Dependencies can be hex.pm packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:amqp, github: "cthulhuology/Amqp"}
    ]
  end
end
