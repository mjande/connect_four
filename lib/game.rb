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
    @player2.assign_symbol(2)
    play_game
  end

  def play_game
    player = @player1
    loop do
      col = player.turn_input(player.number)
      row = @board.find_empty_row(col)
      @board.add_piece(col, row, player.symbol)

      break if @board.win?(col = 0, row = 0) || @board.tie?

      # Switch players between rounds
      if player == @player1
        player = @player2
      else 
        player = @player1
      end
    end
    end_game(player) 
  end

  def end_game(player)
  end
end