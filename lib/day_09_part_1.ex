defmodule Day09Part1 do
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

  defp add_ids(arr, item1, occurrence1, item2, occurrence2) do
    # 0, 1, -1, 2
    # 1, 3, -1, 4
    # 2, 5, -1, 0

    arr
    |> concat(List.duplicate(item1, occurrence1))
    |> concat(List.duplicate(item2, occurrence2))

    # |> for i2 <- 0..occurrence2 do
    #   [item2 | arr]
    # end
  end

  def swap(a, el, from, to) do
    if to < from do
      a
      |> List.replace_at(to, el)
      |> List.replace_at(from, -1)
    else
      a
    end
  end

  def defrag(list) do
    list
    |> reverse()
    |> with_index()
    |> reduce(list, fn {el, idx}, acc ->
      case el do
        -1 -> acc
        _ -> swap(acc, el, length(list) - idx - 1, find_index(acc, fn el -> el == -1 end))
      end
    end)
  end

  def doit(content) do
    content
    |> String.graphemes()
    |> map(&parse!(&1))
    |> chunk_every(2, 2, [0])
    |> with_index()
    |> reduce(~c"", fn val, acc ->
      add_ids(acc, elem(val, 1), at(elem(val, 0), 0), -1, at(elem(val, 0), 1))
    end)
    |> defrag()
    |> map(fn el -> if el == -1, do: 0, else: el end)
    |> with_index()
    |> map(fn {id, pos} -> id * pos end)
    |> sum()
  end
end
