defmodule Day07Part2 do
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

  def cumulate([], []), do: 0

  def cumulate([a | [b | rest]], [op | rest_op]) do
    cumulate([op.(a, b) | rest], rest_op)
  end

  def cumulate([res], _), do: res

  def find_matching_equation({expected_result, operands, combinations}) do
    ## here I have one tuple with result, operands and A LIST of LIST of operators
    combinations
    |> map(fn list_of_operators ->
      cumulate(operands, list_of_operators)
    end)
    |> find(0, fn x -> x == expected_result end)
  end

  defp concatenate(op1, op2) do
    parse!("#{op1}#{op2}")
  end

  def doit(content) do
    String.split(content, "\n")
    |> map(&String.split/1)
    |> map(fn [res | ops] ->
      {
        parse!(elem(String.split_at(res, -1), 0)),
        map(ops, &parse!/1)
      }
    end)
    |> map(fn {res, operands} ->
      %{
        res: res,
        operands: operands,
        combinations: with_repetitions([&+/2, &*/2, &concatenate/2], length(operands) - 1)
      }
    end)
    |> reduce(0, fn el, acc ->
      equation_result = find_matching_equation({el.res, el.operands, el.combinations})
      acc + equation_result
    end)
    |> IO.inspect()
  end

  # see https://www.petecorey.com/blog/2018/11/12/permutations-with-and-without-repetition-in-elixir/
  def with_repetitions([], _k), do: [[]]
  def with_repetitions(_list, 0), do: [[]]

  def with_repetitions(list, k) do
    for head <- list, tail <- with_repetitions(list, k - 1), do: [head | tail]
  end
end
