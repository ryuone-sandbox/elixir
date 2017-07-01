defmodule Hygiene do
  alias HashDict, as: D

  defmacro no_interference do
    quote do: a = 1
  end
  defmacro interference do
    quote do: var!(a) = 1
  end
  defmacro no_interferenceB do
    quote do: D.new
  end

  defmacro write do
    quote do
      a = 1
    end
  end

  # Error
  defmacro read do
    quote do
      a
    end
  end

  defmacrop get_size do
    quote do
      byte_size("hello")
    end
  end

  def return_size do
    import Kernel, except: [byte_size: 1]
    get_size
  end
end
