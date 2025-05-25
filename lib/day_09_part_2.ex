defmodule Day09Part2 do
  import Utils
  import Enum

  def sample do
    content = File.read!(sample_file(__MODULE__))
    measure(fn -> doit(content) end)
  end

  def puzzle do
    content = File.read!(puzzle_file(__MODULE__))
    doit(content)
  end

  defp add_ids(arr, item1, occurrence1, item2, occurrence2) do
    arr
    |> concat(List.duplicate(item1, occurrence1))
    |> concat(List.duplicate(item2, occurrence2))
  end

  defp transform_ids(enumerable) do
    enumerable
    |> with_index()
    |> reduce(~c"", fn val, acc ->
      add_ids(acc, elem(val, 1), at(elem(val, 0), 0), -1, at(elem(val, 0), 1))
    end)
  end

  def find_available_slot(files_map, file_length, slot_index) do
    slot_found =
      files_map
      |> reverse()
      |> find_index(fn slot ->
        slot |> at(0) == -1 && length(slot) >= file_length
      end)

    if slot_found != nil && slot_index < length(files_map) - slot_found,
      do: slot_found,
      else: nil
  end

  def merge_free_slots(acc) do
    List.flatten(acc)
    |> chunk_by(& &1)
  end

  defp defrag(files_as_charlist) do
    files_map = files_as_charlist |> chunk_by(& &1)

    reversed_file_map =
      files_map
      |> reverse()

    reversed_file_map
    |> reduce(reversed_file_map, fn slot, acc ->
      acc = merge_free_slots(acc)

      if at(slot, 0) == -1 do
        acc
      else
        file_length = length(slot)
        slot_index = find_index(acc, fn x -> x == slot end)

        new_file_position =
          find_available_slot(acc, file_length, slot_index)

        case new_file_position do
          nil ->
            acc

          new_file_position ->
            new_file_position = length(acc) - 1 - new_file_position
            free_slot_length = length(at(acc, new_file_position))

            acc =
              case slot_index do
                nil -> acc
                idx -> List.replace_at(acc, idx, List.duplicate(-1, length(slot)))
              end

            cond do
              length(slot) == free_slot_length ->
                acc = List.replace_at(acc, new_file_position, slot)

                acc

              true ->
                new_free_slot = List.duplicate(-1, free_slot_length - length(slot))

                acc = List.replace_at(acc, new_file_position, slot)

                acc =
                  List.insert_at(
                    acc,
                    new_file_position,
                    new_free_slot
                  )

                acc
            end
        end
      end
    end)
  end

  def doit(content) do
    content
    |> String.graphemes()
    |> map(&parse!(&1))
    |> chunk_every(2, 2, [0])
    |> transform_ids()
    |> defrag()
    |> List.flatten()
    |> reverse()
    |> map(fn el -> if el == -1, do: 0, else: el end)
    |> with_index()
    |> map(fn {id, pos} -> id * pos end)
    |> sum()
    |> IO.inspect()
  end
end
