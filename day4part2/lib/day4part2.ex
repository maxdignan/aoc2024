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

      iex> Day4part2.convert_to_char_matrix_and_count_xmas(".M.S......\\n..A..MSMS.\\n.M.S.MAA..\\n..A.ASMSM.\\n.M.S.M....\\n..........\\nS.S.S.S.S.\\n.A.A.A.A..\\nM.M.M.M.M.\\n..........")
      9

  """
  def convert_to_char_matrix_and_count_xmas(input) do
    grid = input
    |> String.split("\n")
    |> Enum.map(&String.split(&1, "", trim: true))

    IO.inspect(grid)

    grid
    |> Enum.with_index()
    |> Enum.map(fn {row, index_x} -> Enum.map(Enum.with_index(row), fn {_char, index_y} -> count_xmas(grid, index_x, index_y) end) end)
    |> IO.inspect()
    |> Enum.map(&Enum.sum/1)
    |> IO.inspect()
    |> Enum.sum()
  end

  def count_xmas(grid, index_x, index_y) do
    # create a list and then sum it
    [
      count_xmas_in_shape(grid, index_x, index_y),
    ]
    |> Enum.sum()
  end


  def count_xmas_in_shape(grid, index_x, index_y) do
    # M
    #
    # M
    # -1, -1 --- +1, -1
    if check_value(grid, index_x, index_y, "A") &&
       check_value(grid, index_x - 1, index_y - 1, "M") &&
       check_value(grid, index_x - 1, index_y + 1, "S") &&
       check_value(grid, index_x + 1, index_y - 1, "M") &&
       check_value(grid, index_x + 1, index_y + 1, "S") do
      1
    # else if
    else
      # M   M
      #
      #
      # -1, -1 --- -1, +1
      if check_value(grid, index_x, index_y, "A") &&
         check_value(grid, index_x - 1, index_y - 1, "M") &&
         check_value(grid, index_x - 1, index_y + 1, "M") &&
         check_value(grid, index_x + 1, index_y - 1, "S") &&
         check_value(grid, index_x + 1, index_y + 1, "S") do
        1
      else
        #    M
        #
        #    M
        # -1, +1 --- +1, +1
        if check_value(grid, index_x, index_y, "A") &&
           check_value(grid, index_x - 1, index_y - 1, "S") &&
           check_value(grid, index_x - 1, index_y + 1, "M") &&
           check_value(grid, index_x + 1, index_y - 1, "S") &&
           check_value(grid, index_x + 1, index_y + 1, "M") do
          1
        else
          #
          #
          # M   M
          # +1, -1 --- +1, +1
          if check_value(grid, index_x, index_y, "A") &&
             check_value(grid, index_x - 1, index_y - 1, "S") &&
             check_value(grid, index_x - 1, index_y + 1, "S") &&
             check_value(grid, index_x + 1, index_y - 1, "M") &&
             check_value(grid, index_x + 1, index_y + 1, "M") do
            1
          else
            0
          end
        end
      end
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
