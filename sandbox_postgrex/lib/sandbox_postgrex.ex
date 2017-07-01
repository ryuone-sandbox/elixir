defmodule SandboxPostgrex do
  require Lager

  def main(_args) do
    try do
      Lager.info "start!"
      run()
      Lager.info "end!"
    catch
      t ->
        Lager.error "catch : #{inspect(t)}"
        wait()
        # IO.puts "rescue : #{inspect(e)}"
        System.halt(2)
    rescue
      e ->
        Lager.error "rescue : #{inspect(e)}"
        wait()
        # IO.puts "rescue : #{inspect(e)}"
        System.halt(2)
    end
  end

  @spec wait() :: :after
  def wait do
    receive do
    after
      200 ->
        :after
    end
  end

  def run() do
    get_pg_version()
  end

  defp get_pg_version do
    { :ok, pid } = Postgrex.Connection.start_link([hostname: "localhost", username: "docker", password: "docker", database: "docker", port: 5432])
    { :ng, result } = Postgrex.Connection.query(pid, "SELECT version()")
    IO.puts inspect(result)
    Postgrex.Connection.stop(pid)
  end
end

