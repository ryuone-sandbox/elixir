defmodule ContextHygiene do
  defmacro write do
    quote do
      var!(a, ContextHygiene) = 1
    end
  end

  defmacro read do
    quote do
      var!(a, ContextHygiene)
    end
  end

  defmacro initialize_to_char_count(variables) do
    IO.inspect variables
    Enum.map variables, fn(name) ->
      var = Macro.var(name, nil)
      length = Atom.to_string(name)|> String.length
      quote do
        unquote(var) = unquote(length)
      end
    end
  end

  def run do
    IO.inspect(initialize_to_char_count [:red, :green, :yellow])
    [red, green, yellow]
  end

end
