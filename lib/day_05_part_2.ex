defmodule Day05Part2 do
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

  defp check_failing(page_numbers, rules) do
    any?(pairs(page_numbers), fn p -> member?(rules, p) end)
  end

  def pairs([]), do: []
  def pairs([_]), do: []

  def pairs(page_numbers) do
    for {x, index1} <- with_index(page_numbers),
        {y, index2} <- with_index(page_numbers) do
      if index1 < index2, do: y <> "|" <> x, else: nil
    end
    |> filter(fn v -> !is_nil(v) end)
  end

  def sort_by_rules(page_numbers, rules) do
    sort(page_numbers, fn el1, el2 -> member?(rules, el1 <> "|" <> el2) end)
  end

  defp get_middle(page_numbers) do
    at(page_numbers, div(length(page_numbers), 2))
    |> parse!()
  end

  def doit(content) do
    [rules, pages] = content |> String.split("\n\n", trim: true)

    pages =
      pages
      |> String.split("\n")
      |> map(&String.split(&1, ","))

    rules = String.split(rules, "\n")

    filter(pages, &check_failing(&1, rules))
    |> map(&sort_by_rules(&1, rules))
    |> map(&get_middle(&1))
    |> sum()
  end
end
