defmodule Day02Part2 do
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

  defp is_safe(report) do
    report =
      if at(report, 0) - at(report, 1) < 0, do: report, else: reverse(report)

    report
    # normalizing sequence to start with 1
    |> map(fn v -> v - at(report, 0) + 1 end)
    |> reduce_while(0, fn el, acc ->
      if el - acc > 0 && el - acc <= 3, do: {:cont, el}, else: {:halt, -1}
    end)
    |> then(fn v -> v != -1 end)
  end

  defp is_safe_single_bad_level(report) do
    if is_safe(report) do
      true
    else
      # checking all possible combinations... :(
      map(0..(count(report) - 1), fn v ->
        List.delete_at(report, v)
      end)
      |> any?(&is_safe/1)
    end
  end

  def doit(content) do
    String.split(content, "\n")
    |> map(&String.split/1)
    |> map(&map(&1, fn elem -> parse!(elem) end))
    |> split_with(fn report -> is_safe_single_bad_level(report) end)
    |> elem(0)
    |> count()
  end
end
