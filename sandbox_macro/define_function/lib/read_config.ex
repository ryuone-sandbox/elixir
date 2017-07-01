# defmodule Adder do
#   require PgpassRecord

#   defmacro define_fnA(pgpass_data) do
#     quote bind_quoted: [pgpass_data: pgpass_data] do
#       IO.inspect pgpass_data
#       IO.inspect Record.record?(pgpass_data)
#       def get_pg_data(pgpass_data) do
#         pgpass_data
#       end
#     end
#   end

#   defmacro define_fnB(pgpass_data) do
#     _pgpass_data = Macro.escape(pgpass_data, unquote: true)
#     IO.inspect _pgpass_data
#     IO.inspect pgpass_data
#     quote do
#       x = Macro.escape(unquote(pgpass_data), unquote: true)
#       IO.inspect x
#       def get_pg_data(x) do
#         IO.puts "!!"
#       end
#     end
#     # quote do
#     #   IO.inspect _pgpass_data
#     #   # IO.inspect unquote(pgpass_data)
#     #   # IO.inspect Record.record?(unquote(pgpass_data))
#     #   def get_pg_data(unquote(_pgpass_data)=pgpass_data) do
#     #     IO.inspect(Record.record?(pgpass_data, :pgpass))
#     #     # # IO.inspect PgpassRecord.pgpass(pgpass_data)
#     #     # pgpass_data
#     #   end
#     # end
#   end
# end

defmodule ReadConfig do
  require PgpassRecord
  def init do
    {:ok, bin} = File.read("./config/p.conf")
    result = bin |> String.split("\n") |> resolution
    # IO.inspect result
    # Enum.each result, fn(x) ->
    #   IO.inspect x
    # end
  end

  def resolution(config_arr), do: resolution(config_arr, [])
  def resolution([], acc), do: acc
  def resolution([""|t], acc), do: resolution(t, acc)
  def resolution([<<"#", _rest::binary>>|t], acc), do: resolution(t, acc)
  def resolution([h|t], acc) do
    ltuple = String.split(h, ":") |> List.to_tuple
    {_, r} = {ltuple, PgpassRecord.pgpass} |>
      set_hostname |>
      set_port |>
      set_database |>
      set_username |>
      set_password
    resolution(t, [r|acc])
  end

  defp set_hostname({t, r}) do
    case (t |> elem 0) do
      "*" -> {t, r}
      v -> {t, PgpassRecord.pgpass(r, hostname: v)}
    end
  end
  defp set_port({t, r}) do
    case (t |> elem 1) do
      "*" -> {t, r}
      v -> {t, PgpassRecord.pgpass(r, port: v)}
    end
  end
  defp set_database({t, r}) do
    case (t |> elem 2) do
      "*" -> {t, r}
      v -> {t, PgpassRecord.pgpass(r, database: v)}
    end
  end
  defp set_username({t, r}) do
    case (t |> elem 3) do
      "*" -> {t, r}
      v -> {t, PgpassRecord.pgpass(r, username: v)}
    end
  end
  defp set_password({t, r}) do
    case (t |> elem 4) do
      "*" -> {t, r}
      v -> {t, PgpassRecord.pgpass(r, password: v)}
    end
  end
end

# defmodule DefineFunctionA do
#   require Record
#   require ReadConfig
#   require Adder

#   result = ReadConfig.init
#   Enum.each result, fn(x) ->
#     Adder.define_fnA(x)
#   end
# end

# defmodule DefineFunctionB do
#   require PgpassRecord
#   require Record
#   require ReadConfig
#   require Adder

#   Adder.define_fnB(PgpassRecord.pgpass)
# end

# defmodule DefineFunctionC do
#   require PgpassRecord
#   _pgpass1 = PgpassRecord.pgpass
#   _pgpass2 = Macro.escape(PgpassRecord.pgpass, unquote: true)
#   _pgpass3 = Macro.escape(PgpassRecord.pgpass, unquote: false)

#   IO.inspect _pgpass1
#   IO.inspect _pgpass2
#   IO.inspect _pgpass3
#   def get_pg_data(unquote(_pgpass2)) do
#     IO.puts "*****"
#   end
# end


defmodule Adder do
  defmacro addfunc(r) do
    # escape = Macro.escape(r, unquote: true)
    # expr = Macro.escape(r, unquote: true)
    quote do
      ep = Macro.escape(unquote(r))
      IO.inspect ep
      def x(ep=value) do
        IO.inspect "*****"
        IO.inspect ep
        IO.inspect value
        # IO.inspect value
        # IO.inspect unquote(e)
        # IO.inspect unquote(r)
      end
    end
  end
end


# defmodule DefineFunctionD do
#   result = ReadConfig.init
#   Enum.each result, fn(x) ->
#     _pgpass = Macro.escape(x, unquote: true)
#     IO.inspect _pgpass
#     def get_pg_data(unquote(_pgpass)=pgpass) do
#       IO.inspect unquote(_pgpass)
#       IO.inspect pgpass.password
#     end
#   end
# end


defmodule DefineFunctionE do
  require Adder
  require PgpassRecord
  r = PgpassRecord.pgpass
  Adder.addfunc(r)
end

