defmodule StackTraceAdder do
  @doc "Defines a function that adds two numbers"
  defmacro defadd do
    quote location: :keep do
      def add(a, b), do: a ++ b
    end
  end
end
