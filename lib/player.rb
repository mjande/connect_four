# frozen_string_literal: true

# The Player class handles interactions and inputs from the player throughout
# the game
class Player
  attr_reader :name, :symbol, :number

  def welcome
    puts "let's play Connect Four!"
  end

  def assign_name(player_num)
    puts "Player ##{player_num}: Please type your name below."
    @name = gets.chomp
    @number = player_num
  end

  def assign_symbol
    @symbol = @number == 1 ? '○' : '●'
    color = @number == 1 ? 'white' : 'black'
    puts "#{@name}, you will be playing as #{color} (#{@symbol})."
  end

  def turn_input
    puts "#{@name}, where would you like to play your next piece?"
    loop do
      input = gets.to_i
      return input if input.is_a?(Integer) && input.between?(0, 6)

      puts 'Please input a number between 0 and 6.'
    end
  end

  def win_message
    puts "#{@name} wins!"
  end

  def tie_message
    puts "Tie game!"
  end

  def play_again?
    puts 'Would you like to play again? (Y or N)'
    loop do
      case gets.chomp.upcase
      when 'Y'
        return true
      when 'N'
        puts 'Thanks for playing!'
        return false
      end
      puts 'Please enter Y or N.'
    end
  end
end
