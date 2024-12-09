defmodule Day04Test do
  use ExUnit.Case

  @tag :kip
  test "day 4, part 1 with sample data" do
    assert Day04Part1.sample() == 18
  end

  @tag :skip
  test "day 4, part 1 with puzzle" do
    assert Day04Part1.puzzle() == 2406
  end

  @tag :no_skip
  test "day 4, part 3 with sample data" do
    assert Day04Part2.sample() == 9
  end
end
