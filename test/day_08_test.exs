defmodule Day08Test do
  use ExUnit.Case

  # T....#....
  # ...T......
  # .T....#...
  # .........#
  # ..#.......
  # ..........
  # ...#......
  # ..........
  # ....#.....
  # ..........
  @tag :skip
  test "day 8, part 2 get antinodes for (0,0) and (2,2)" do
    assert Day08Part2.get_antinodes_for_frequency([{0, 0}, {2, 2}], 10, 10) == [
             {8, 8},
             {6, 6},
             {4, 4}
           ]
  end

  @tag :skip
  test "day 8, part 2 get antinodes for (0,0) and (3,1)" do
    assert Day08Part2.get_antinodes_for_frequency([{0, 0}, {3, 1}], 10, 10) == [{9, 3}, {6, 2}]
  end

  @tag :skip
  test "day 8, part 2 get antinodes for (2,2) and (4,4)" do
    assert Day08Part2.get_antinodes_for_frequency([{2, 2}, {4, 4}], 10, 10) == [
             {8, 8},
             {6, 6},
             {0, 0}
           ]
  end
end
