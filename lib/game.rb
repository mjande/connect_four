# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

# Game class creates and stores the players and board, and handles the game
# loop from beginning to end.
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
      coordinates = @board.find_empty_row(col, player)
      @board.add_piece(coordinates[0], coordinates[1], player.symbol)
      if @board.win?(coordinates[0], coordinates[1])
        player.win_message
        break
      elsif @board.tie?
        player.tie_message
        break
      end
      # Switch players between rounds
      player = (player == @player1 ? @player2 : @player1)
    end
    end_game
  end

  def end_game
    @board.display
    return unless @player1.play_again?

    @board = Board.new
    start_game
  end
end
