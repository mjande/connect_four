require_relative 'board'
require_relative 'player'

class Game
  def initialize
    @board = Board.new
    @player1 = Player.new
    @player2 = Player.new
  end
  
  def start_game
    @player1.welcome
    @player1.assign_name(1)
    @player1.assign_symbol
    @player2.assign_name(2)
    @player2.assign_symbol
    play_game
  end

  def play_game
    player = @player1
    loop do
      @board.display
      col = player.turn_input
      row = @board.find_empty_row(col)
      @board.add_piece(col, row, player.symbol)
      break if @board.win?(col, row) || @board.tie?

      # Switch players between rounds
      player = (player == @player1 ? @player2 : @player1)
    end
    end_game(player) 
  end

  def end_game(player)
    puts "#{player.name} wins!"
    if player.play_again?
      @board = Board.new
      start_game
    end
  end
end