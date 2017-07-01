defmodule Lazy do
  defmacrop get_map_size do
    quote do
      size([a: 1, b: 2])
    end
  end
  def return_map_size do
    import Dict, only: [size: 1]
    get_map_size
  end

  defmacro get_byte_size do
    import Kernel, except: [byte_size: 1]
    quote do
      byte_size("12345")
    end
  end
  def return_byte_size do
    get_byte_size
  end

  def get_byte_size_normal do
    # import Kernel, except: [byte_size: 1]
    byte_size("12345")
  end
  def return_byte_size_normal do
    # import Kernel, except: [byte_size: 1]
    get_byte_size_normal
  end
end
