defmodule Unless do
  def fun_unless(clause, expression) do
    if(!clause, do: expression)
  end

  defmacro macro_unless(clause, expression) do
    quote do
      if(!unquote(clause), do: unquote(expression))
    end
  end

  def expr do
    quote do
      macro_unless false, IO.puts("xxxx")
    end
  end
  def expand_expr do
    Macro.expand_once expr, __ENV__
  end
  def expand_string do
    IO.puts(Macro.to_string(expand_expr))
  end
  def get_kernel_unless_expand do
    quote(do: unless(true, do: IO.puts("111"))) |> Macro.expand(__ENV__)
    |> Macro.to_string
  end
end
