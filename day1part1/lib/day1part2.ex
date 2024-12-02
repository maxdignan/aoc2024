defmodule Day1part2 do
  @moduledoc """
  Documentation for `Day1part2`.
  """

  @spec hello() :: :world
  @doc """
  Hello world.

  ## Examples

      iex> Day1part2.hello()
      :world

  """
  def hello do
    :world
  end

  @spec sum_distances(binary()) :: any()
  @doc """
  Calculate the similarity score between the two lists (the left hand list and the right hand list). Take each item in the left hand list. Multiply it by the
  number of times it appears in the right hand list. Sum all of these values.

  ## Examples

      iex> Day1part2.sum_distances("1 2\\n3 4")
      2

      iex> Day1part2.sum_distances("3   4\\n4   3\\n2   5\\n1   3\\n3   9\\n3   3")
      31
  """
  def sum_distances(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn line -> String.split(line, " ", trim: true) end)
    |> Enum.map(fn [x, y] -> {String.to_integer(x), String.to_integer(y)} end)
    # take each atom, put each element into a list by whether it is on the right or the left
    |> Enum.reduce({[], []}, fn {x, y}, {left, right} ->
      {List.insert_at(left, 0, x), List.insert_at(right, 0, y)}
    end)
    |> then(fn {left, right} -> Enum.reduce(
        left,
        0,
        fn left_value, acc ->
          acc + left_value * Enum.count(right, fn right_value ->
            right_value == left_value
          end)
        end)
      end)
  end
end
