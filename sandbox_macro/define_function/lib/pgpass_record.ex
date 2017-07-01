defmodule PgpassRecord do
  require Record

  Record.defrecord :pgpass, [hostname: "", port: 5432, database: "", username: "", password: ""]
end