defmodule Day08Part1 do
  import Utils
  import Enum

  @type row() :: list(String.t())
  @type matrix() :: list(row)
  @type map_of_antennas() :: %{integer => [{integer, integer}]}

  def sample do
    content = File.read!(sample_file(__MODULE__))
    doit(content)
  end

  def puzzle do
    content = File.read!(puzzle_file(__MODULE__))
    doit(content)
  end

  def get_antennas_positions(content) do
    width =
      length(content |> String.split("\n") |> at(0) |> to_charlist())

    content_as_list =
      content
      |> String.split("\n")
      |> join()
      |> to_charlist()

    content_as_list
    |> with_index()
    |> reduce(%{}, fn {el, idx}, acc ->
      x = rem(idx, width)
      y = div(idx, width)

      if el == ?. do
        acc
      else
        add_position_to_map(acc, el, {x, y})
      end
    end)
  end

  def add_position_to_map(acc, el, pos) do
    if Map.has_key?(acc, el) do
      Map.put(acc, el, [pos | acc[el]])
    else
      Map.put(acc, el, [pos])
    end
  end

  def get_antinodes(antennas_position) do
    # E.g %{48 => [{4, 4}, {7, 3}, {5, 2}, {8, 1}], 65 => [{9, 9}, {8, 8}, {6, 5}]}
    # Expected output:
    # [[{x,y}, {w,z}], ... [{m, n}, {o, p}]]

    antennas_position
    |> map(fn el ->
      get_antinodes_for_frequency(elem(el, 1))
    end)
  end

  def get_antinodes_for_frequency(el) do
    comb(2, el)
    |> map(fn [{x1, y1}, {x2, y2}] ->
      [
        {x2 + (x2 - x1), y2 + (y2 - y1)},
        {x1 - (x2 - x1), y1 - (y2 - y1)}
      ]
    end)
    |> List.flatten()
  end

  def filter_outside_grid(antinodes, width, height) do
    antinodes
    |> filter(fn antinode ->
      x = elem(antinode, 0)
      y = elem(antinode, 1)

      x >= 0 && x < width && y >= 0 && y < height
    end)
  end

  def doit(content) do
    matrix =
      String.split(content, "\n")
      |> map(&String.to_charlist/1)

    {width, height} = matrix |> then(fn m -> {m |> at(0) |> length(), m |> length()} end)

    content
    |> get_antennas_positions()
    |> get_antinodes()
    |> List.flatten()
    |> filter_outside_grid(width, height)
    |> uniq()
    |> count()
  end
end
