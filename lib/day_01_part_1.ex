defmodule Day01Part1 do
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

  def doit(content) do
    lists =
      String.split(content, "\n")
      |> map(&String.split/1)
      |> map(fn line -> [parse!(at(line, 0)), parse!(at(line, 1))] end)
      |> zip_reduce([], fn elements, acc -> [elements | acc] end)
      |> map(&sort/1)

    zip_reduce(at(lists, 0), at(lists, 1), 0, fn l, r, acc ->
      acc + abs(l - r)
    end)
  end
end
