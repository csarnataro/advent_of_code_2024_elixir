defmodule Day04Part2 do
  import Utils
  import Enum

  def sample do
    content = File.read!(sample_file(__MODULE__))
    doit(content)
  end

  defp elem_at(matrix, x, y) do
    matrix
    |> at(y)
    |> at(x)
  end

  def puzzle do
    content = File.read!(puzzle_file(__MODULE__))
    doit(content)
  end

  def m_m(matrix, x, y) do
    try do
      cond do
        elem_at(matrix, x, y) == ?M &&
          elem_at(matrix, x + 1, y + 1) == ?A &&
          elem_at(matrix, x + 2, y + 2) == ?S &&
          elem_at(matrix, x, y + 2) == ?M &&
            elem_at(matrix, x + 2, y) == ?S ->
          1

        true ->
          0
      end
    rescue
      _ -> 0
    end
  end

  def m_s(matrix, x, y) do
    try do
      cond do
        elem_at(matrix, x, y) == ?M &&
          elem_at(matrix, x + 1, y + 1) == ?A &&
          elem_at(matrix, x + 2, y + 2) == ?S &&
          elem_at(matrix, x, y + 2) == ?S &&
            elem_at(matrix, x + 2, y) == ?M ->
          1

        true ->
          0
      end
    rescue
      _ -> 0
    end
  end

  def s_s(matrix, x, y) do
    try do
      cond do
        elem_at(matrix, x, y) == ?S &&
          elem_at(matrix, x + 1, y + 1) == ?A &&
          elem_at(matrix, x + 2, y + 2) == ?M &&
          elem_at(matrix, x, y + 2) == ?S &&
            elem_at(matrix, x + 2, y) == ?M ->
          1

        true ->
          0
      end
    rescue
      _ -> 0
    end
  end

  def s_m(matrix, x, y) do
    try do
      cond do
        elem_at(matrix, x, y) == ?S &&
          elem_at(matrix, x + 1, y + 1) == ?A &&
          elem_at(matrix, x + 2, y + 2) == ?M &&
          elem_at(matrix, x, y + 2) == ?M &&
            elem_at(matrix, x + 2, y) == ?S ->
          1

        true ->
          0
      end
    rescue
      _ -> 0
    end
  end

  def how_many_x_mas(matrix, width) do
    matrix
    |> join()
    |> String.to_charlist()
    |> reduce(%{idx: 0, x: 0, y: 0, xmas: 0}, fn _el, acc ->
      x = rem(acc.idx, width)
      y = if acc.x == width - 1, do: acc.y + 1, else: acc.y

      xmas =
        s_s(matrix, x, y) +
          s_m(matrix, x, y) +
          m_m(matrix, x, y) +
          m_s(matrix, x, y)

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

    %{xmas: xmas} = how_many_x_mas(matrix, width)

    xmas
  end
end