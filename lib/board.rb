class Board
  attr_reader :data_array
  
  def initialize
    @data_array = Array.new(7) { Array.new(6) } 
  end

  def display 
    5.downto(0) do |row|
      7.times do |col|
        if data_array[col][row].nil?
          print "|   "
        else
          print "| #{@data_array[col][row]} "
        end
      end
      puts "|"
      puts "-----------------------------"
    end 
  end

  def add_piece(column, symbol)
    row = find_empty_row(column)
    if @data_array[column][row].nil?
      @data_array[column][row] = symbol 
    end
  end

  def check_for_win(column, row)
    check_for_row_win(column, row) || 
    check_for_col_win(column, row) ||
    check_for_left_diag_win(column, row) ||
    check_for_right_diag_win(column, row)
  end

  # Check for tie needed

  private

  def find_empty_row(column)
    6.downto(0) do |row|
      if !@data_array[column][row].nil?
        return row + 1
      end
    end
    0
  end 

  def check_for_row_win(column, row)
    pieces_in_a_row = 1
    symbol = @data_array[column][row]
    last_col = column
    while @data_array[last_col - 1][row] == symbol # Check left
      pieces_in_a_row += 1
      last_col -= 1
    end
    last_col = column
    while @data_array[last_col + 1][row] == symbol # Check right
      pieces_in_a_row += 1
      last_col += 1
    end
    pieces_in_a_row >= 4
  end

  def check_for_col_win(column, row)
    pieces_in_a_row = 1
    symbol = @data_array[column][row]
    while @data_array[column][row - 1] == symbol # Check down
      pieces_in_a_row += 1
      row -= 1
    end
    # No need to check from middle or bottom, due to Connect Four rules
    pieces_in_a_row >= 4
  end

  def check_for_left_diag_win(column, row)
    pieces_in_a_row = 1
    symbol = @data_array[column][row]
    last_col = column
    last_row = row
    while @data_array[last_col - 1][last_row + 1] == symbol
      pieces_in_a_row += 1
      last_col -= 1 
      last_row += 1
    end
    last_col = column
    last_row = row
    while @data_array[last_col + 1][last_row - 1] == symbol
      pieces_in_a_row += 1
      last_col += 1
      last_row -= 1
    end
    pieces_in_a_row >= 4
  end

  def check_for_right_diag_win(column, row)
    pieces_in_a_row = 1
    symbol = @data_array[column][row]
    last_col = column
    last_row = row
    while @data_array[last_col - 1][last_row - 1] == symbol
      pieces_in_a_row += 1
      last_col -= 1 
      last_row -= 1
    end
    last_col = column
    last_row = row
    while @data_array[last_col + 1][last_row + 1] == symbol
      pieces_in_a_row += 1
      last_col += 1
      last_row += 1
    end
    pieces_in_a_row >= 4
  end
end

=begin
mid_row_win = Board.new
mid_row_win.create
mid_row_win.add_piece(0, '○')
mid_row_win.add_piece(1, '○')
mid_row_win.add_piece(3, '○')
mid_row_win.add_piece(2, '○')
mid_row_win.check_for_win(2, 0)
=end
