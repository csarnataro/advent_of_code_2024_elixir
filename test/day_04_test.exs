defmodule Day04Test do
  use ExUnit.Case

  @tag :skip
  test "day 4, part 1 with sample data" do
    assert Day04Part1.sample() == 18
  end

  @tag :skip
  test "day 4, find element in matrix" do
    matrix = [
      ~c"XMAS",
      ~c".S..",
      ~c".A..",
      ~c".M.."
    ]

    assert Day04Part1.elem_at(matrix, 0, 0) == ?X
    assert Day04Part1.elem_at(matrix, 1, 1) == ?S
    assert Day04Part1.elem_at(matrix, 3, 0) == ?S
  end

  @tag :noskip
  test "day 4, find 1 xmas in matrix" do
    matrix = [
      ~c"XMAS",
      ~c".S..",
      ~c".A..",
      ~c".M.."
    ]

    assert Day04Part1.how_many_xmas(matrix) == 1
  end

  @tag :noskip
  test "day 4, find 2 xmas in matrix" do
    matrix = [
      ~c"XMAS",
      ~c"M...",
      ~c"A...",
      ~c"S..."
    ]

    assert Day04Part1.how_many_xmas(matrix) == 2
  end

  @tag :noskip
  test "day 4, find 3 xmas in matrix" do
    matrix = [
      ~c"XMAS",
      ~c"MM..",
      ~c"A.A.",
      ~c"S..S"
    ]

    assert Day04Part1.how_many_xmas(matrix) == 3
  end

  @tag :noskip
  test "day 4, find xmas horizontal" do
    matrix = [
      ~c"XMAS",
      ~c".S..",
      ~c".A..",
      ~c".M.."
    ]

    assert Day04Part1.xmas_horizontal(matrix) == 1
  end

  @tag :noskip
  test "day 4, NOT find xmas vertical" do
    matrix = [
      ~c"XMAS",
      ~c".S..",
      ~c".A..",
      ~c".M.."
    ]

    assert Day04Part1.xmas_vertical(matrix) == 0
  end

  @tag :noskip
  test "day 4, find xmas vertical" do
    matrix = [
      ~c"X...",
      ~c"M...",
      ~c"A...",
      ~c"S..."
    ]

    assert Day04Part1.xmas_vertical(matrix) == 1
  end
end
