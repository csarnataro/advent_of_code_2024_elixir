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

  def xmas_vertical(idx, matrix_as_single_line) do
    # cond do
    #   elem_at(matrix, 0, 0) == ?X &&
    #     elem_at(matrix, 0, 1) == ?M &&
    #     elem_at(matrix, 0, 2) == ?A &&
    #       elem_at(matrix, 0, 3) == ?S ->
    #     1

    #   elem_at(matrix, 0, 0) == ?S &&
    #     elem_at(matrix, 0, 1) == ?A &&
    #     elem_at(matrix, 0, 2) == ?M &&
    #       elem_at(matrix, 0, 3) == ?X ->
    #     1

    #   true ->
    #     0
    # end
    1
  end

  def xmas_horizontal(idx, matrix_as_single_line) do
    # cond do
    #   elem_at(matrix, 0, 0) == ?X &&
    #     elem_at(matrix, 1, 0) == ?M &&
    #     elem_at(matrix, 2, 0) == ?A &&
    #       elem_at(matrix, 3, 0) == ?S ->
    #     1

    #   elem_at(matrix, 0, 0) == ?S &&
    #     elem_at(matrix, 1, 0) == ?A &&
    #     elem_at(matrix, 2, 0) == ?M &&
    #       elem_at(matrix, 3, 0) == ?X ->
    #     1

    #   true ->
    #     0
    # end
    1
  end

  def xmas_diagonal(idx, matrix_as_single_line) do
    # cond do
    #   elem_at(matrix, 0, 0) == ?X &&
    #     elem_at(matrix, 1, 1) == ?M &&
    #     elem_at(matrix, 2, 2) == ?A &&
    #       elem_at(matrix, 3, 3) == ?S ->
    #     1

    #   elem_at(matrix, 0, 0) == ?S &&
    #     elem_at(matrix, 1, 1) == ?A &&
    #     elem_at(matrix, 2, 2) == ?M &&
    #       elem_at(matrix, 3, 3) == ?X ->
    #     1

    #   true ->
    #     0
    # end
    1
  end

  # def how_many_xmas(matrix) do
  #   cond do
  #     length(matrix) < 3 && length(at(matrix, 0)) < 3 ->
  #       0

  #     length(matrix) >= 3 && length(at(matrix, 0)) >= 3 ->
  #       xmas_horizontal(matrix) + xmas_vertical(matrix) + xmas_diagonal(matrix)

  #     length(at(matrix, 0)) < 3 ->
  #       xmas_horizontal(matrix)

  #     length(matrix) < 3 ->
  #       xmas_vertical(matrix)
  #   end
  # end

  def is_on_last_columns(idx, width) do
    rem(idx, width) >= width - 3
  end

  def is_on_last_rows(idx, width, height) do
    idx > width * (height - 3)
  end

  def has_no_char_left(idx, width, height) do
    is_on_last_columns(idx, width) && is_on_last_rows(idx, width, height)
  end

  def doit(content) do
    splitted = String.split(content, "\n")

    # compute width and height before merging everything
    width = splitted |> at(0) |> String.length()
    height = length(splitted)

    matrix_as_single_line = content |> String.replace("\n", "") |> String.to_charlist()
    #matrix_length = length(matrix_as_single_line)

    matrix_as_single_line
    |> reduce(%{idx: 0, xmas: 0}, fn _c, acc ->
      %{idx: idx, xmas: xmas} = acc

      found_xmas =
        cond do
          has_no_char_left(acc.idx, width, height) ->
            0

          is_on_last_columns(idx, width) ->
            xmas_vertical(idx, matrix_as_single_line)

          is_on_last_rows(idx, width, height) ->
            xmas_horizontal(idx, matrix_as_single_line)

          true ->
            xmas_vertical(idx, matrix_as_single_line)
            +xmas_horizontal(idx, matrix_as_single_line)
            +xmas_diagonal(idx, matrix_as_single_line)
        end

      %{idx: idx + 1, xmas: xmas + found_xmas}
    end)
    |> IO.inspect()
    # |> filter(fn c -> at(c, 0) == ?X end)

    matrix_as_single_line
  end
end
