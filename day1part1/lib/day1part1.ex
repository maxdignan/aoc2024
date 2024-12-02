defmodule Day1part1 do
  @moduledoc """
  Documentation for `Day1part1`.
  """

  @spec hello() :: :world
  @doc """
  Hello world.

  ## Examples

      iex> Day1part1.hello()
      :world

  """
  def hello do
    :world
  end

  @spec sum_distances(binary()) :: any()
  @doc """
  Calculate the sum of the distances between the two numbers in each line of the input, but first sort the right-hand side and left-hand side by smallest to largest.

  ## Examples

      iex> Day1part1.sum_distances("1 2\\n3 4")
      2

      iex> Day1part1.sum_distances("3   4\\n4   3\\n2   5\\n1   3\\n3   9\\n3   3")
      11
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
    |> then(fn {left, right} -> {Enum.sort(left), Enum.sort(right)} end)
    |> then(fn {left, right} -> Enum.zip(left, right) end)
    |> Enum.reduce(0, fn {x, y}, acc -> acc + abs(y - x) end)
  end
end
