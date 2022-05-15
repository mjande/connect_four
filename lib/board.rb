class Board
  attr_reader :data_array
  
  def create
    @data_array = Array.new(7) { Array.new(6) } 
  end

  def display 
    6.times do |row|
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
end