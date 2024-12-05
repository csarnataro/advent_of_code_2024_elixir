defmodule Day03Part2 do
  import Utils
  import Enum

  def sample do
    content = File.read!(sample_file(__MODULE__))
    doit(content)
  end

  def sample2 do
    content = File.read!(sample_file(__MODULE__))
    doit(content)
  end

  def puzzle do
    content = File.read!(puzzle_file(__MODULE__))
    doit(content)
  end

  defp tokens(expr) do
    Regex.scan(~r/mul\((\d{1,3}),(\d{1,3})\)|do\(\)|don't\(\)/, expr)
  end

  def eval(["mul(" <> _, n1, n2]) do
    parse!(n1) * parse!(n2)
  end

  def eval(["do()"]) do
    :do
  end

  def eval(["don't()"]) do
    :dont
  end

  def eval_tokens(tokens) do
    tokens
    |> reduce(%{active: true, partial: 0}, fn el, acc ->
      case eval(el) do
        :do ->
          %{active: true, partial: acc.partial}

        :dont ->
          %{active: false, partial: acc.partial}

        value ->
          %{active: acc.active, partial: acc.partial + if(acc.active, do: value, else: 0)}
      end
    end)
    |> tap(&IO.inspect/1)
  end

  def doit(content) do
    [String.replace(content, "\n", "")]
    |> map(&tokens/1)
    |> map(&eval_tokens/1)
    |> map(fn v -> v.partial end)
    |> sum()
  end
end
