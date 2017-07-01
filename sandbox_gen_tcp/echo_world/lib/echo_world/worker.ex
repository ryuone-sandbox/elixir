defmodule EchoWorld.Worker do
  require Logger
  use GenServer

  def start_link(port) do
    :gen_server.start_link({:local, :echo_world}, __MODULE__, port, [])
  end

  def init(port) do
    {:ok, listen_socket} = :gen_tcp.listen(port,
        [:binary, {:packet, :raw}, {:active, false}, {:reuseaddr, true}, {:nodelay, true}]
      )
    Logger.info "listening port: #{port}"
    spawn(__MODULE__, :accept, [listen_socket])
    {:ok, HashDict.new}
  end

  def accept(listen_socket) do
    {:ok, socket} = :gen_tcp.accept(listen_socket)
    spawn(__MODULE__, :process_command, [socket])
    accept(listen_socket)
  end

  def process_command(sock) do
    case :gen_tcp.recv(sock, 0) do
      {:ok, line} ->
        Logger.info line
        IO.inspect line
        process_command(sock)
      {:error, :close} ->
        Logger.info "closed"
      _ ->
        Logger.error "error"
    end
  end
end
