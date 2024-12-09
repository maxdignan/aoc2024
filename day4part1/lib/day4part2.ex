defmodule Day4part2 do
  @moduledoc """
  Documentation for `Day4part2`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Day4part2.hello()
      :world

  """
  def hello do
    :world
  end


  @spec convert_to_char_matrix_and_count_xmas(any()) :: none()
  @doc """
  Converts a string to a matrix of characters and counts the number of XMAS's in the matrix

  ## Examples

      iex> Day4part2.convert_to_char_matrix_and_count_xmas("XMAS\\nXMAS")
      0

      iex> Day4part2.convert_to_char_matrix_and_count_xmas(".M.S......\\n..A..MSMS.\\n.M.S.MAA..\\n..A.ASMSM.\\b.M.S.M....\\n..........\\nS.S.S.S.S.\\n.A.A.A.A..\\nM.M.M.M.M.\\n..........")
      8

  """
  def convert_to_char_matrix_and_count_xmas(input) do
    grid = input
    |> String.split("\n")
    |> Enum.map(&String.split(&1, "", trim: true))

    grid
    |> Enum.with_index()
    |> Enum.map(fn {row, index_x} -> Enum.map(Enum.with_index(row), fn {_char, index_y} -> count_xmas(grid, index_x, index_y) end) end)
    |> Enum.map(&Enum.sum/1)
    |> Enum.sum()
  end

  def count_xmas(grid, index_x, index_y) do
    # create a list and then sum it
    [
      count_xmas_in_shape(grid, index_x, index_y),
    ]
    |> Enum.sum()
  end

  # return 0 if the char at (index_x, index_y) is not A,
  # Return 1 if the char at (index_x, index_y) is A AND (-1, -1) is M, (-1, +1) is S, (+1, -1) is M and (+1, +1) is S
  def count_xmas_in_shape(grid, index_x, index_y) do
    if check_value(grid, index_x, index_y, "A") &&
       check_value(grid, index_x - 1, index_y - 1, "M") &&
       check_value(grid, index_x - 1, index_y + 1, "S") &&
       check_value(grid, index_x + 1, index_y - 1, "M") &&
       check_value(grid, index_x + 1, index_y + 1, "S") do
      1
    else
      0
    end
  end

  def count_xmas_north(grid, index_x, index_y) do
    if check_value(grid, index_x, index_y, "X") &&
       check_value(grid, index_x - 1, index_y, "M") &&
       check_value(grid, index_x - 2, index_y, "A") &&
       check_value(grid, index_x - 3, index_y, "S") do
      1
    else
      0
    end
  end

  def count_xmas_north_east(grid, index_x, index_y) do
    if check_value(grid, index_x, index_y, "X") &&
       check_value(grid, index_x - 1, index_y + 1, "M") &&
       check_value(grid, index_x - 2, index_y + 2, "A") &&
       check_value(grid, index_x - 3, index_y + 3, "S") do
      1
    else
      0
    end
  end

  def count_xmas_east(grid, index_x, index_y) do
    if check_value(grid, index_x, index_y, "X") &&
       check_value(grid, index_x, index_y + 1, "M") &&
       check_value(grid, index_x, index_y + 2, "A") &&
       check_value(grid, index_x, index_y + 3, "S") do
      1
    else
      0
    end
  end

  def count_xmas_south_east(grid, index_x, index_y) do
    if check_value(grid, index_x, index_y, "X") &&
       check_value(grid, index_x + 1, index_y + 1, "M") &&
       check_value(grid, index_x + 2, index_y + 2, "A") &&
       check_value(grid, index_x + 3, index_y + 3, "S") do
      1
    else
      0
    end
  end

  def count_xmas_south(grid, index_x, index_y) do
    if check_value(grid, index_x, index_y, "X") &&
       check_value(grid, index_x + 1, index_y, "M") &&
       check_value(grid, index_x + 2, index_y, "A") &&
       check_value(grid, index_x + 3, index_y, "S") do
      1
    else
      0
    end
  end

  def count_xmas_south_west(grid, index_x, index_y) do
    if check_value(grid, index_x, index_y, "X") &&
       check_value(grid, index_x + 1, index_y - 1, "M") &&
       check_value(grid, index_x + 2, index_y - 2, "A") &&
       check_value(grid, index_x + 3, index_y - 3, "S") do
      1
    else
      0
    end
  end

  def count_xmas_west(grid, index_x, index_y) do
    if check_value(grid, index_x, index_y, "X") &&
       check_value(grid, index_x, index_y - 1, "M") &&
       check_value(grid, index_x, index_y - 2, "A") &&
       check_value(grid, index_x, index_y - 3, "S") do
      1
    else
      0
    end
  end

  def count_xmas_north_west(grid, index_x, index_y) do
    if check_value(grid, index_x, index_y, "X") &&
       check_value(grid, index_x - 1, index_y - 1, "M") &&
       check_value(grid, index_x - 2, index_y - 2, "A") &&
       check_value(grid, index_x - 3, index_y - 3, "S") do
      1
    else
      0
    end
  end

  def check_value(grid, index_x, index_y, char) do
    if index_x < 0 || index_x >= length(grid) || index_y < 0 || index_y >= length(Enum.at(grid, index_x, 0)) do
      false
    else
      if Enum.at(Enum.at(grid, index_x, []), index_y, "") == char do
        true
      else
        false
      end
    end
  end
end
