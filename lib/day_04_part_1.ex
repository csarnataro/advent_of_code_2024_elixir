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

  defp elem_at(matrix, x, y) do
    matrix
    |> at(y)
    |> at(x)
  end

  def xmas_vertical(matrix, x, y) do
    try do
      cond do
        elem_at(matrix, x, y) == ?X &&
          elem_at(matrix, x, y + 1) == ?M &&
          elem_at(matrix, x, y + 2) == ?A &&
            elem_at(matrix, x, y + 3) == ?S ->
          1

        elem_at(matrix, x, y) == ?S &&
          elem_at(matrix, x, y + 1) == ?A &&
          elem_at(matrix, x, y + 2) == ?M &&
            elem_at(matrix, x, y + 3) == ?X ->
          1

        true ->
          0
      end
    rescue
      _ -> 0
    end
  end

  def xmas_horizontal(matrix, x, y) do
    try do
      found =
        cond do
          elem_at(matrix, x, y) == ?X &&
            elem_at(matrix, x + 1, y) == ?M &&
            elem_at(matrix, x + 2, y) == ?A &&
              elem_at(matrix, x + 3, y) == ?S ->
            1

          elem_at(matrix, x, y) == ?S &&
            elem_at(matrix, x + 1, y) == ?A &&
            elem_at(matrix, x + 2, y) == ?M &&
              elem_at(matrix, x + 3, y) == ?X ->
            1

          true ->
            0
        end

      found
    rescue
      _ -> 0
    end
  end

  def xmas_diagonal_down(matrix, x, y) do
    try do
      cond do
        elem_at(matrix, x, y) == ?X &&
          elem_at(matrix, x + 1, y + 1) == ?M &&
          elem_at(matrix, x + 2, y + 2) == ?A &&
            elem_at(matrix, x + 3, y + 3) == ?S ->
          1

        elem_at(matrix, x, y) == ?S &&
          elem_at(matrix, x + 1, y + 1) == ?A &&
          elem_at(matrix, x + 2, y + 2) == ?M &&
            elem_at(matrix, x + 3, y + 3) == ?X ->
          1

        true ->
          0
      end
    rescue
      _ -> 0
    end
  end

  def xmas_diagonal_up(matrix, x, y) do
    try do
      cond do
        elem_at(matrix, x, y) == ?X &&
          elem_at(matrix, x + 1, y - 1) == ?M &&
          elem_at(matrix, x + 2, y - 2) == ?A &&
            elem_at(matrix, x + 3, y - 3) == ?S ->
          1

        elem_at(matrix, x, y) == ?S &&
          elem_at(matrix, x + 1, y - 1) == ?A &&
          elem_at(matrix, x + 2, y - 2) == ?M &&
            elem_at(matrix, x + 3, y - 3) == ?X ->
          1

        true ->
          0
      end
    rescue
      _ -> 0
    end
  end

  def how_many_xmas(matrix, width) do
    matrix
    |> join()
    |> String.to_charlist()
    |> reduce(%{idx: 0, x: 0, y: 0, xmas: 0}, fn _el, acc ->
      x = rem(acc.idx, width)
      y = if acc.x == width - 1, do: acc.y + 1, else: acc.y

      xmas =
        xmas_vertical(matrix, x, y) +
          xmas_horizontal(matrix, x, y) +
          xmas_diagonal_down(matrix, x, y) +
          xmas_diagonal_up(matrix, x, y)

      %{idx: acc.idx + 1, x: x, y: y, xmas: acc.xmas + xmas}
    end)
  end

  def doit(content) do
    matrix =
      String.split(content, "\n")
      |> map(&String.to_charlist/1)

    # compute width and height before merging everything
    width =
      matrix
      |> at(0)
      |> length()

    %{xmas: xmas} = how_many_xmas(matrix, width)

    xmas
  end
end
