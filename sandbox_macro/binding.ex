defmodule Binding do
  # kv = [foo: 1, bar: 2]
  # Enum.each kv, fn {k, v} ->
  #   def unquote(k)(), do: unquote(v)
  # end
  defmacro defkvA(kv) do
    Enum.map kv, fn {k, v} ->
      quote do
        def unquote(k)(), do: unquote(v)
      end
    end
  end
  defmacro defkvB(kv) do
    quote bind_quoted: [kv: kv] do
      Enum.each kv, fn {k, v} ->
        def unquote(k)(), do: unquote(v)
      end
    end
  end
end

defmodule ModA do
  require Binding
  Binding.defkvA [foo: 1, bar: 2]
#  kv = [foo: 1, bar: 2]
#  Binding.defkvB kv
end
defmodule ModB do
  require Binding
  kv = [foo: 1, bar: 2]
  Binding.defkvB kv
end