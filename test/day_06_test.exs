defmodule Day06Test do
  use ExUnit.Case

  @tag :skip
  test "day 4, part 2 with sample data" do
    assert Day06Part2.sample() == 6
  end

  @tag :noskip
  test "add obstruction at 0 0" do
    matrix = [
      ~c"....#.....",
      ~c".........#",
      ~c"..........",
      ~c"..#.......",
      ~c".......#..",
      ~c"..........",
      ~c".#..^.....",
      ~c"........#.",
      ~c"#.........",
      ~c"......#..."
    ]

    matrix_with_obstruction = [
      ~c"#...#.....",
      ~c".........#",
      ~c"..........",
      ~c"..#.......",
      ~c".......#..",
      ~c"..........",
      ~c".#..^.....",
      ~c"........#.",
      ~c"#.........",
      ~c"......#..."
    ]

    assert Day06Part2.add_obstruction(matrix, 0, 0) == matrix_with_obstruction
  end

  @tag :noskip
  test "add obstruction at 9 9" do
    matrix = [
      ~c"....#.....",
      ~c".........#",
      ~c"..........",
      ~c"..#.......",
      ~c".......#..",
      ~c"..........",
      ~c".#..^.....",
      ~c"........#.",
      ~c"#.........",
      ~c"......#..."
    ]

    matrix_with_obstruction = [
      ~c"....#.....",
      ~c".........#",
      ~c"..........",
      ~c"..#.......",
      ~c".......#..",
      ~c"..........",
      ~c".#..^.....",
      ~c"........#.",
      ~c"#.........",
      ~c"......#..#"
    ]

    assert Day06Part2.add_obstruction(matrix, 9, 9) == matrix_with_obstruction
  end

  @tag :noskip
  test "add obstruction at 3 6" do
    matrix = [
      ~c"....#.....",
      ~c".........#",
      ~c"..........",
      ~c"..#.......",
      ~c".......#..",
      ~c"..........",
      ~c".#..^.....",
      ~c"........#.",
      ~c"#.........",
      ~c"......#..."
    ]

    matrix_with_obstruction = [
      ~c"....#.....",
      ~c".........#",
      ~c"..........",
      ~c"..#.......",
      ~c".......#..",
      ~c"..........",
      ~c".#.#^.....",
      ~c"........#.",
      ~c"#.........",
      ~c"......#..."
    ]

    assert Day06Part2.add_obstruction(matrix, 3, 6) == matrix_with_obstruction
  end
end
