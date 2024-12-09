defmodule Day06Part1 do
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

  defp elem_at(matrix, x, y) do
    matrix
    |> at(y)
    |> at(x)
  end

  defp change_dir(:up), do: :right
  defp change_dir(:right), do: :down
  defp change_dir(:down), do: :left
  defp change_dir(:left), do: :up

  def compute_next(%{dir: :up, y: y, x: x, matrix: matrix, positions: positions}) do
    case elem_at(matrix, x, y) do
      ?# ->
        %{
          dir: change_dir(:up),
          y: y + 1,
          x: x + 1,
          matrix: matrix,
          positions: positions
        }

      _ ->
        %{
          dir: :up,
          y: y - 1,
          x: x,
          matrix: matrix,
          positions: MapSet.put(positions, {x, y})
        }
    end
  end

  def compute_next(%{dir: :right, y: y, x: x, matrix: matrix, positions: positions}) do
    case elem_at(matrix, x, y) do
      ?# ->
        %{
          dir: change_dir(:right),
          y: y + 1,
          x: x - 1,
          matrix: matrix,
          positions: positions
        }

      _ ->
        %{
          dir: :right,
          y: y,
          x: x + 1,
          matrix: matrix,
          positions: MapSet.put(positions, {x, y})
        }
    end
  end

  def compute_next(%{dir: :down, y: y, x: x, matrix: matrix, positions: positions}) do
    case elem_at(matrix, x, y) do
      ?# ->
        %{
          dir: change_dir(:down),
          y: y - 1,
          x: x - 1,
          matrix: matrix,
          positions: positions
        }

      _ ->
        %{
          dir: :down,
          y: y + 1,
          x: x,
          matrix: matrix,
          positions: MapSet.put(positions, {x, y})
        }
    end
  end

  def compute_next(%{dir: :left, y: y, x: x, matrix: matrix, positions: positions}) do
    case elem_at(matrix, x, y) do
      ?# ->
        %{
          dir: change_dir(:left),
          y: y - 1,
          x: x + 1,
          matrix: matrix,
          positions: positions
        }

      _ ->
        %{
          dir: :left,
          y: y,
          x: x - 1,
          matrix: matrix,
          positions: MapSet.put(positions, {x, y})
        }
    end
  end

  def doit(content) do
    matrix =
      String.split(content, "\n")
      |> map(&String.to_charlist/1)

    %{y: y, x: x} = find_guard_position(matrix)

    initial_state = %{dir: :up, y: y, x: x, matrix: matrix, positions: MapSet.new()}

    {width, height} = matrix |> then(fn m -> {m |> at(0) |> length(), m |> length()} end)

    Stream.unfold(initial_state, fn acc ->
      if acc.y == -1 || acc.x == -1 || acc.y == height || acc.x == width do
        nil
      else
        next_acc = compute_next(acc)
        {acc, next_acc}
      end
    end)
    |> take(-1)
    |> at(0)
    |> then(fn v -> v[:positions] end)
    |> MapSet.size()
    |> Kernel.+(1)
  end

  defp find_guard_position(matrix) do
    reduce_while(matrix, %{y: 0}, fn el, acc ->
      if member?(el, ?^) do
        x = find_index(el, fn v -> v == ?^ end)
        {:halt, %{y: acc.y, x: x, full_row: el}}
      else
        {:cont, %{y: acc.y + 1}}
      end
    end)
  end
end
