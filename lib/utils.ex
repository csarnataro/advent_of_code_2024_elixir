defmodule Utils do
  def mod(full_module_name) do
    full_module_name
    |> to_string()
    |> String.split(".")
    |> Enum.at(1)
  end

  def parse!(s), do: Integer.parse(s) |> elem(0)

  def sample_file(module_name) do
    "data/#{mod(module_name)}/sample.txt"
  end

  def puzzle_file(module_name) do
    "data/#{mod(module_name)}/puzzle.txt"
  end
end
