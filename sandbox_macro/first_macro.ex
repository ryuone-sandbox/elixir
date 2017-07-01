defmodule FirstMacro do
  def a do
    values = [2, 3, 4]
    quote do: sum(1, unquote_splicing(values), 5)
  end
  def b do
    v = 13
    quote do: sum(1, value, 3)
  end
  def c do
    Macro.to_string(quote do: sum(value, 1, 2 + 3, 4))
  end
  def d do
    quote do: d
  end
  defmacro squaredA(x) do
    quote do
      unquote(x) * unquote(x)
    end
  end
  defmacro squaredB(x) do
    quote bind_quoted: [x: x] do
      x * x
    end
  end
  defmacro squaredC(x) do
    quote do
      x = unquote(x)
      x * x
    end
  end
  def e do
    my_number = fn ->
      IO.puts "Returning 5"
      5
    end
    IO.puts "1)"
    squaredA(my_number.())
    IO.puts "2)"
    squaredB(my_number.())
    IO.puts "3)"
    squaredC(my_number.())
  end

  def func_unless(clause, expression) do
    IO.puts "!!!"
    if !clause do
      expression
    end
    # if(!clause, do: expression)
  end

  defmacro macro_unless(clause, expression) do
    IO.puts clause
    IO.puts inspect(expression)
    quote do
      if(!unquote(clause), do: unquote(expression))
    end
  end
end
