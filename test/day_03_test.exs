defmodule Day03Test do
  use ExUnit.Case

  @tag :skip
  test "day 3, part 1 with sample data" do
    assert Day03Part1.sample() == 161
  end

  @tag :skip
  test "day 3, part 2 with sample data" do
    assert Day03Part2.sample() == 48
  end

  @tag :skip
  test "day 3, part 2 with full puzzle data" do
    assert Day03Part2.puzzle() == 63_013_756
  end
end
