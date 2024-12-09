defmodule Day05Test do
  use ExUnit.Case

  @tag :noskip
  test "day 4, part 2 with sample data" do
    assert Day05Part2.sample() == 123
  end

  @tag :skip
  test "day 4, part 1 with sample data" do
    assert Day05Part1.sample() == 143
  end

  @tag :skip
  test "get_pairs" do
    assert Day05Part1.pairs(["75", "97", "47", "61", "53"]) |> length() ==
             [
               "75|97",
               "75|47",
               "75|61",
               "75|53",
               "97|47",
               "97|61",
               "97|53",
               "47|61",
               "47|53",
               "61|53"
             ]
             |> length()
  end

  @tag :skip
  test "get_pairs with just 1 pair" do
    assert Day05Part1.pairs(["75", "97"]) == ["97|75"]
  end

  @tag :skip
  test "get_pairs with 3 pairs" do
    assert Day05Part1.pairs(["75", "97", "47"]) == ["97|75", "47|75", "47|97"]
  end
end
