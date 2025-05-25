defmodule Day06Part2 do
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

  def add_obstruction(matrix, x, y) do
    new_line =
      matrix
      |> at(y)
      |> List.update_at(x, fn _ -> ?# end)

    matrix |> List.update_at(y, fn _ -> new_line end)
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
        if MapSet.member?(positions, {:up, x, y}) do
          %{found_loop: true}
        else
          %{
            dir: :up,
            y: y - 1,
            x: x,
            matrix: matrix,
            positions: MapSet.put(positions, {:up, x, y})
          }
        end
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
        if MapSet.member?(positions, {:right, x, y}) do
          %{found_loop: true}
        else
          %{
            dir: :right,
            y: y,
            x: x + 1,
            matrix: matrix,
            positions: MapSet.put(positions, {:right, x, y})
          }
        end
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
        if MapSet.member?(positions, {:down, x, y}) do
          %{found_loop: true}
        else
          %{
            dir: :down,
            y: y + 1,
            x: x,
            matrix: matrix,
            positions: MapSet.put(positions, {:down, x, y})
          }
        end
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
        if MapSet.member?(positions, {:left, x, y}) do
          %{found_loop: true}
        else
          %{
            dir: :left,
            y: y,
            x: x - 1,
            matrix: matrix,
            positions: MapSet.put(positions, {:left, x, y})
          }
        end
    end
  end

  def doit(content) do
    matrix =
      String.split(content, "\n")
      |> map(&String.to_charlist/1)

    %{y: y, x: x} = find_guard_position(matrix)
    {width, height} = matrix |> then(fn m -> {m |> at(0) |> length(), m |> length()} end)

    for obstruction_y <- 0..(height - 1),
        obstruction_x <- 0..(width - 1) do
      # to avoid the initial position
      if !(obstruction_x == x && obstruction_y == y) do
        tentative_matrix = add_obstruction(matrix, obstruction_x, obstruction_y)

        initial_state = %{
          dir: :up,
          y: y,
          x: x,
          matrix: tentative_matrix,
          positions: MapSet.new()
        }

        search_for_loops(initial_state, width, height)
      end
    end
    |> filter(&(!is_nil(&1)))
    |> sum()
    |> IO.inspect()
  end

  def search_for_loops(initial_state, width, height) do
    reduce_while(Stream.iterate(:just_start, & &1), initial_state, fn _el, acc ->
      if acc.y == -1 || acc.x == -1 || acc.y == height || acc.x == width do
        {:halt, 0}
      else
        next_acc = compute_next(acc)

        if Map.has_key?(next_acc, :found_loop) do
          {:halt, 1}
        else
          {:cont, next_acc}
        end
      end

      # x = function()
      # y = function()

      # if x != y,
      #   do: {:cont, :some_value},
      #   else: {:halt, :final_return_value}
    end)

    # Stream.unfold(initial_state, fn acc ->
    #   if acc.y == -1 || acc.x == -1 || acc.y == height || acc.x == width do
    #     nil
    #   else
    #     next_acc = compute_next(acc)
    #     {acc, next_acc}
    #   end
    # end)

    # |> take(-1)
    # |> at(0)
    # |> then(fn v -> v[:positions] end)
    # |> MapSet.size()
    # |> Kernel.+(1)
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

  # def while_cond(condition, while_body) when condition == false do
  #   while_body.()
  # end

  # def while_cond(_, while_body) do
  #   new_cond = while_body.()
  #   while_cond(new_cond, while_body)
  # end
end
