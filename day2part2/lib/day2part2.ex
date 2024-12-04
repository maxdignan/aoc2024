defmodule Day2part2 do
  @moduledoc """
  Documentation for `Day2part2`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Day2part2.hello()
      :world

  """
  def hello do
    :world
  end

  @spec count_safe_reports_with_problem_dampener(binary()) :: any()
  @doc """
  Determine the number of reports that are "safe". Each report is one line of the input string. Each line is a list of space-separated integers.
  A report is safe if the sequence of integers is either monotonically increasing or monotonically decreasing.
  On top of that, it must only increase or decrease by at most 3 between each integer.
  The adjustment to this is that the we actually need to count the number of times that the grouped numbers are not safe. If that count is 0 or 1, then the report is still safe.


  ## Examples

      iex> Day2part2.count_safe_reports_with_problem_dampener("1 2\\n3 4")
      2

      iex> Day2part2.count_safe_reports_with_problem_dampener("1 1\\n4 0")
      2

      iex> Day2part2.count_safe_reports_with_problem_dampener("1 1 1\\n4 0 1")
      1

      iex> Day2part2.count_safe_reports_with_problem_dampener("7 6 4 2 1\\n1 2 7 8 9\\n9 7 6 2 1\\n1 3 2 4 5\\n8 6 4 4 1\\n1 3 6 7 9")
      4
  """
  def count_safe_reports_with_problem_dampener(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.count(&is_safe_report/1)
  end

  defp is_safe_report(report) do
    numbers =
      report
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)

    subreports = ListUtils.remove_each_one(numbers)

    subreports
    |> Enum.any?(&is_sub_report_safe/1)
  end

  defp is_sub_report_safe(numbers) do
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
