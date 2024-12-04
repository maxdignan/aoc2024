defmodule Day3part1 do
  @moduledoc """
  Documentation for `Day3part1`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Day3part1.hello()
      :world

  """
  def hello do
    :world
  end

  @spec sum_muls_w_instructions(binary()) :: any()
  @doc """

  ## Examples

      iex> Day3part1.sum_muls_w_instructions("mul(1,2)")
      2

      iex> Day3part1.sum_muls_w_instructions("mul( 1, 2)")
      0

      iex> Day3part1.sum_muls_w_instructions("mul(3,4),mul(5,6)")
      42

      iex> Day3part1.sum_muls_w_instructions("xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))")
      48
  """
  def sum_muls_w_instructions(input) do
    do_string = get_all_do_strings(input)
    sum_muls(do_string)
  end

  def get_all_do_strings("") do
    ""
  end
  def get_all_do_strings(input) do
    [do_string | dont_do_strings] = String.split(input, "don't()")
    do_string <> get_all_do_strings_from_starting_dont(Enum.join(dont_do_strings, "don't()"))
  end

  def get_all_do_strings_from_starting_dont("") do
    ""
  end
  def get_all_do_strings_from_starting_dont(input) do
    [_ | do_string] = String.split(input, "do()")
    get_all_do_strings(Enum.join(do_string, "do()"))
  end

  @spec sum_muls(binary()) :: any()
  @doc """

  ## Examples

      iex> Day3part1.sum_muls("mul(1,2)")
      2

      iex> Day3part1.sum_muls("mul( 1, 2)")
      0

      iex> Day3part1.sum_muls("mul(3,4),mul(5,6)")
      42

      iex> Day3part1.sum_muls("xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))")
      161
  """
  def sum_muls(input) do
    regex = ~r/mul\((\d{1,3}),(\d{1,3})\)/

    muls = Regex.scan(regex, input)

    muls
    |> Enum.map(fn [_, a, b] -> String.to_integer(a) * String.to_integer(b) end)
    |> Enum.sum()
  end
end
