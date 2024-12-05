defmodule Day04Test do
  use ExUnit.Case

  @tag :skip
  test "day 4, part 1 with sample data" do
    assert Day04Part1.sample() == 18
  end

  # @tag :skip
  # test "day 4, find element in matrix" do
  #   matrix = [
  #     ~c"XMAS",
  #     ~c".S..",
  #     ~c".A..",
  #     ~c".M.."
  #   ]

  #   assert Day04Part1.elem_at(matrix, 0, 0) == ?X
  #   assert Day04Part1.elem_at(matrix, 1, 1) == ?S
  #   assert Day04Part1.elem_at(matrix, 3, 0) == ?S
  # end

  # @tag :noskip
  # test "day 4, find 1 xmas in matrix" do
  #   matrix = [
  #     ~c"XMAS",
  #     ~c".S..",
  #     ~c".A..",
  #     ~c".M.."
  #   ]

  #   assert Day04Part1.how_many_xmas(matrix) == 1
  # end

  # @tag :noskip
  # test "day 4, find 2 xmas in matrix" do
  #   matrix = [
  #     ~c"XMAS",
  #     ~c"M...",
  #     ~c"A...",
  #     ~c"S..."
  #   ]

  #   assert Day04Part1.how_many_xmas(matrix) == 2
  # end

  # @tag :noskip
  # test "day 4, find 3 xmas in matrix" do
  #   matrix = [
  #     ~c"XMAS",
  #     ~c"MM..",
  #     ~c"A.A.",
  #     ~c"S..S"
  #   ]

  #   assert Day04Part1.how_many_xmas(matrix) == 3
  # end

  # @tag :noskip
  # test "day 4, find xmas horizontal" do
  #   matrix = [
  #     ~c"XMAS",
  #     ~c".S..",
  #     ~c".A..",
  #     ~c".M.."
  #   ]

  #   assert Day04Part1.xmas_horizontal(matrix) == 1
  # end

  # @tag :noskip
  # test "day 4, NOT find xmas vertical" do
  #   matrix = [
  #     ~c"XMAS",
  #     ~c".S..",
  #     ~c".A..",
  #     ~c".M.."
  #   ]

  #   assert Day04Part1.xmas_vertical(matrix) == 0
  # end

  # @tag :noskip
  # test "day 4, find xmas vertical" do
  #   matrix = [
  #     ~c"X...",
  #     ~c"M...",
  #     ~c"A...",
  #     ~c"S..."
  #   ]

  #   assert Day04Part1.xmas_vertical(matrix) == 1
  # end

  test "1,1 is NOT on last columns" do
    assert Day04Part1.is_on_last_columns(1, 10) == false
  end

  test "7,8 and 9 are on last columns" do
    assert Day04Part1.is_on_last_columns(9, 10) == true
    assert Day04Part1.is_on_last_columns(8, 10) == true
    assert Day04Part1.is_on_last_columns(7, 10) == true
    assert Day04Part1.is_on_last_columns(6, 10) == false
  end

  test "7, 8 and 9 on a real matrix are on last columns" do
    content = "MMMSXXMASM
    MSAMXMSMSA
    AMXSXMAAMM
    MSAMASMSMX
    XMASAMXAMM
    XXAMMXXAMA
    SMSMSASXSS
    SAXAMASAAA
    MAMMMXMMMM
    MXMXAXMASX"

    splitted = String.split(content, "\n")

    # compute width and height before merging everything
    width = splitted |> Enum.at(0) |> String.length()
    height = length(splitted)

    matrix_as_single_line = content |> String.replace("\n", "") |> String.to_charlist()

    assert Day04Part1.is_on_last_columns(19, width) == true
    assert Day04Part1.is_on_last_columns(18, width) == true
    assert Day04Part1.is_on_last_columns(17, width) == true
    assert Day04Part1.is_on_last_columns(16, width) == false
  end

  test "cells on a real matrix are on last columns" do
    content = "MMMSXXMASM
    MSAMXMSMSA
    AMXSXMAAMM
    MSAMASMSMX
    XMASAMXAMM
    XXAMMXXAMA
    SMSMSASXSS
    SAXAMASAAA
    MAMMMXMMMM
    MXMXAXMASX"

    splitted = String.split(content, "\n")

    # compute width and height before merging everything
    width = splitted |> Enum.at(0) |> String.length()
    height = length(splitted)

    matrix_as_single_line = content |> String.replace("\n", "") |> String.to_charlist()

    assert Day04Part1.is_on_last_rows(19, width, height) == false
    assert Day04Part1.is_on_last_rows(18, width, height) == false
    assert Day04Part1.is_on_last_rows(17, width, height) == false
    assert Day04Part1.is_on_last_rows(16, width, height) == false

    assert Day04Part1.is_on_last_rows(99, width, height) == true
    assert Day04Part1.is_on_last_rows(88, width, height) == true
    assert Day04Part1.is_on_last_rows(77, width, height) == true
    assert Day04Part1.is_on_last_rows(90, width, height) == true
    assert Day04Part1.is_on_last_rows(80, width, height) == true
    assert Day04Part1.is_on_last_rows(70, width, height) == true
    assert Day04Part1.is_on_last_rows(66, width, height) == false


  end
end
