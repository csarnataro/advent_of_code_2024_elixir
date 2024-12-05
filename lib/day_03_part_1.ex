defmodule Day03Part1 do
  import Utils
  import Enum

  def sample do
    content = File.read!(sample_file(__MODULE__))
    doit(content)
  end

  def puzzle do
    content = File.read!(puzzle_file(__MODULE__))
    doit(content)
  end

  defp get_mul(line) do
    Regex.scan(~r/mul\(\d{1,3},\d{1,3}\)/, line)
  end

  defp mul(expr) do
    tokens = Regex.scan(~r/mul\((\d{1,3}),(\d{1,3})\)/, expr)
    parse!(at(tokens, 0) |> at(1)) * parse!(at(tokens, 0) |> at(2))
  end

  def doit(content) do
    String.split(content, "\n")
    |> map(&get_mul/1)
    |> List.flatten()
    |> map(&mul/1)
    |> sum()
  end
end
