defmodule Day2part1 do
  @moduledoc """
  Documentation for `Day2part1`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Day2part1.hello()
      :world

  """
  def hello do
    :world
  end

  @spec count_safe_reports(binary()) :: any()
  @doc """
  Determine the number of reports that are "safe". Each report is one line of the input string. Each line is a list of space-separated integers.
  A report is safe if the sequence of integers is either monotonically increasing or monotonically decreasing.
  On top of that, it must only increase or decrease by at most 3 between each integer.

  ## Examples

      iex> Day2part1.count_safe_reports("1 2\\n3 4")
      2

      iex> Day2part1.count_safe_reports("1 1\\n4 0")
      0

      iex> Day2part1.count_safe_reports("7 6 4 2 1\\n1 2 7 8 9\\n9 7 6 2 1\\n1 3 2 4 5\\n8 6 4 4 1\\n1 3 6 7 9")
      2
  """
  def count_safe_reports(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.count(&is_safe_report/1)
  end

  defp is_safe_report(report) do
    numbers =
      report
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)

    Enum.chunk_every(numbers, 2, 1, :discard)
    |> Enum.all?(&is_safe_sequence/1) and (monotonically_increasing?(numbers) or monotonically_decreasing?(numbers))
  end

  defp is_safe_sequence([a, b]) do
    abs(a - b) <= 3
  end

  defp monotonically_increasing?([_]), do: true
  defp monotonically_increasing?([a, b | rest]), do: a < b and monotonically_increasing?([b | rest])

  defp monotonically_decreasing?([_]), do: true
  defp monotonically_decreasing?([a, b | rest]), do: a > b and monotonically_decreasing?([b | rest])
end
