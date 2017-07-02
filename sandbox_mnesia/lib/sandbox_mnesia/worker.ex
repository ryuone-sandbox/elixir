defmodule SandboxMnesia.Worker do
  use GenServer

  require Logger

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init() do
    {:ok, []}
  end

  def handle_info(_data, state) do
    {:reply, state}
  end

  def handle_call(_req, _from, state) do
    {:reply, [], state}
  end

end