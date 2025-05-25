defmodule Day10Test do
  use ExUnit.Case

  @tag :noskip
  test "find available slot 1" do
    assert Day10Part1.sample() == 36
  end
end
