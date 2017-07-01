defmodule StackTraceSample do
  import StackTraceAdder
  defadd

  def call_addA do
    add 1, 2
  end
  def call_addB do
    add "1", "a"
  end
end
