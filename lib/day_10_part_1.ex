defmodule Day10Part1 do
  import Utils
  import Enum

  def sample do
    content = File.read!(sample_file(__MODULE__))
    measure(fn -> doit(content) end)
  end

  def puzzle do
    content = File.read!(puzzle_file(__MODULE__))
    doit(content)
  end

  def doit(content) do
    a = 1
    b = 2
    c = sum(a, b)

    content <> Integer.to_string(c)
  end

  defp sum(a, b) do
    a + b
  end
end
