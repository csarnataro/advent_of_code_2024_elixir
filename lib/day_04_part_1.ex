defmodule Day04Part1 do
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

  def elem_at(matrix, x, y) do
    matrix
    |> at(y)
    |> at(x)
  end

  def xmas_vertical(matrix) do
    cond do
      elem_at(matrix, 0, 0) == ?X &&
        elem_at(matrix, 0, 1) == ?M &&
        elem_at(matrix, 0, 2) == ?A &&
          elem_at(matrix, 0, 3) == ?S ->
        1

      elem_at(matrix, 0, 0) == ?S &&
        elem_at(matrix, 0, 1) == ?A &&
        elem_at(matrix, 0, 2) == ?M &&
          elem_at(matrix, 0, 3) == ?X ->
        1

      true ->
        0
    end
  end

  def xmas_horizontal(matrix) do
    cond do
      elem_at(matrix, 0, 0) == ?X &&
        elem_at(matrix, 1, 0) == ?M &&
        elem_at(matrix, 2, 0) == ?A &&
          elem_at(matrix, 3, 0) == ?S ->
        1

      elem_at(matrix, 0, 0) == ?S &&
        elem_at(matrix, 1, 0) == ?A &&
        elem_at(matrix, 2, 0) == ?M &&
          elem_at(matrix, 3, 0) == ?X ->
        1

      true ->
        0
    end
  end

  def xmas_diagonal(matrix) do
    cond do
      elem_at(matrix, 0, 0) == ?X &&
        elem_at(matrix, 1, 1) == ?M &&
        elem_at(matrix, 2, 2) == ?A &&
          elem_at(matrix, 3, 3) == ?S ->
        1

      elem_at(matrix, 0, 0) == ?S &&
        elem_at(matrix, 1, 1) == ?A &&
        elem_at(matrix, 2, 2) == ?M &&
          elem_at(matrix, 3, 3) == ?X ->
        1

      true ->
        0
    end
  end

  def how_many_xmas(matrix) do
    cond do
      length(matrix) < 3 && length(at(matrix, 0)) < 3 ->
        0

      length(matrix) >= 3 && length(at(matrix, 0)) >= 3 ->
        xmas_horizontal(matrix) + xmas_vertical(matrix) + xmas_diagonal(matrix)

      length(at(matrix, 0)) < 3 ->
        xmas_horizontal(matrix)

      length(matrix) < 3 ->
        xmas_vertical(matrix)
    end
  end

  def doit(content) do
    matrix =
      String.split(content, "\n")
      |> map(&String.to_charlist/1)

    width =
      length(at(matrix, 0))
      |> IO.inspect()

    height =
      length(matrix)
      |> IO.inspect()

    first..last = 0..(width - 3)

    # |> map(&String.split/1)

    # |> filter(fn c -> at(c, 0) == ?X end)
  end
end
