# frozen_string_literal: true

# Board class stores an array containing all the positions on the board, and
# contains methods for displaying, editing, and checking that board data array
class Board
  attr_reader :data_array

  def initialize
    @data_array = Array.new(7) { Array.new(6) }
  end

  def display
    5.downto(0) do |row|
      7.times do |col|
        if data_array[col][row].nil?
          print '|   '
        else
          print "| #{@data_array[col][row]} "
        end
      end
      puts "|\n-----------------------------"
    end
  end

  def find_empty_row(column)
    0.upto(5) do |row|
      return row if @data_array[column][row].nil?
    end
    nil
  end

  def add_piece(column, row, symbol)
    @data_array[column][row] = symbol if @data_array[column][row].nil?
  end

  def win?(column, row)
    row_win?(column, row) ||
      col_win?(column, row) ||
      left_diag_win?(column, row) ||
      right_diag_win?(column, row)
  end

  def tie?
    @data_array.any? do |col|
      col.none?(&:nil?)
    end
    # Possibly add a method for checking whether a win is possible
    # even with empty spaces
  end



  private

  def row_win?(column, row)
    pieces_in_a_row = 1
    symbol = @data_array[column][row]
    pieces_in_a_row += check_to_left(column, row, symbol)
    pieces_in_a_row += check_to_right(column, row, symbol)
    pieces_in_a_row >= 4
  end

  def check_to_left(column, row, symbol)
    pieces_to_left = 0
    while @data_array[column - 1][row] == symbol
      pieces_to_left += 1
      column -= 1
    end
    pieces_to_left
  end

  def check_to_right(column, row, symbol)
    pieces_to_right = 0
    while @data_array[column + 1][row] == symbol
      pieces_to_right += 1
      column += 1
    end
    pieces_to_right
  end

  def col_win?(column, row)
    pieces_in_a_row = 1
    symbol = @data_array[column][row]
    while @data_array[column][row - 1] == symbol # Check down
      pieces_in_a_row += 1
      row -= 1
    end
    # No need to check from middle or bottom, due to Connect Four rules
    pieces_in_a_row >= 4
  end

  def left_diag_win?(column, row)
    pieces_in_a_row = 1
    symbol = @data_array[column][row]
    pieces_in_a_row += check_to_upper_left(column, row, symbol)
    pieces_in_a_row += check_to_lower_right(column, row, symbol)
    pieces_in_a_row >= 4
  end

  def check_to_upper_left(column, row, symbol)
    pieces_to_upper_left = 0
    while @data_array[column - 1][row + 1] == symbol
      pieces_to_upper_left += 1
      column -= 1
      row += 1
    end
    pieces_to_upper_left
  end

  def check_to_lower_right(column, row, symbol)
    pieces_to_lower_right = 0
    while @data_array[column + 1][row - 1] == symbol
      pieces_to_lower_right += 1
      column += 1
      row -= 1
    end
    pieces_to_lower_right
  end

  def right_diag_win?(column, row)
    pieces_in_a_row = 1
    symbol = @data_array[column][row]
    pieces_in_a_row += check_to_lower_left(column, row, symbol)
    pieces_in_a_row += check_to_upper_right(column, row, symbol)
    pieces_in_a_row >= 4
  end

  def check_to_lower_left(column, row, symbol)
    pieces_to_lower_left = 0
    while @data_array[column - 1][row - 1] == symbol
      pieces_to_lower_left += 1
      column -= 1
      row -= 1
    end
    pieces_to_lower_left
  end

  def check_to_upper_right(column, row, symbol)
    pieces_to_upper_right = 0
    while @data_array[column + 1][row + 1] == symbol
      pieces_to_upper_right += 1
      column += 1
      row += 1
    end
    pieces_to_upper_right
  end
end
