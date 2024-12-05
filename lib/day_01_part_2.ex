defmodule Day01Part2 do
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

  defp weight(frequencies, el) do
    case Map.fetch(frequencies, el) do
      {:ok, value} -> value
      _ -> 0
    end
  end

  def doit(content) do
    String.split(content, "\n")

    [list_0, list_1] =
      String.split(content, "\n")
      |> map(&String.split/1)
      |> map(fn line -> [parse!(at(line, 0)), parse!(at(line, 1))] end)
      |> zip_reduce([], fn elements, acc -> [elements | acc] end)

    frequencies =
      split_with(list_1, fn el -> member?(list_0, el) end)
      |> elem(0)
      |> frequencies()

    reduce(list_0, 0, fn el, acc -> acc + el * weight(frequencies, el) end)
  end
end
