defmodule ListUtils do
  def remove_each_one(list) do
    Enum.with_index(list)
    |> Enum.map(fn {_, index} ->
      List.delete_at(list, index)
    end)
  end
end
