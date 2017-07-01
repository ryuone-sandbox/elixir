defmodule DefineStruct do
  defstruct [hostname: nil, port: nil, database: nil, username: nil, password: nil]
end

defmodule Pgpassdata do
  ###
  # This struct from $HOME/.pgpass.
  ###
  def get do
    _pg1 = %DefineStruct{database: "pg1", password: "pg1password"}
    _pg2 = %DefineStruct{database: "pg2", port: 5432, password: "pg2password"}
    [_pg1|[_pg2]]
  end
end

defmodule DefineFunction do
  list = Pgpassdata.get

  Enum.each list, fn(pgpass) ->
    opt = Keyword.new([hostname: pgpass.hostname, port: pgpass.port, database: pgpass.database, username: pgpass.username])
    opt = Enum.reject opt, fn(y) ->
      case y do
        {_, nil} -> true
        _ -> false
      end
    end
    IO.inspect opt
    password = pgpass.password

    def get_password(%DefineStruct{unquote_splicing(opt)}=_val) do
      unquote(password)
    end
  end
end

defmodule Main do
  def get do
    # => "pg1password"
    IO.puts DefineFunction.get_password %DefineStruct{database: "pg1"}
    # => error
    # IO.puts DefineFunction.get_password %DefineStruct{database: "pg2"}
    # => "pg2password"
    IO.puts DefineFunction.get_password %DefineStruct{database: "pg2", port: 5432}
    # => error
    # IO.puts DefineFunction.get_password %DefineStruct{database: "pg3"}
  end
end