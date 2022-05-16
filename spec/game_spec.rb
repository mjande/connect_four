# frozen_string_literal: true

require_relative '../lib/game.rb'

describe Game do
  describe '#start_game' do
    subject(:new_game) { described_class.new }
    let(:board) do 
      double('board', 
        display_board: nil)
    end
    let(:player1) do
      double('player1', 
        welcome: nil, 
        assign_name: nil, 
        assign_symbol: nil)
    end
    let(:player2) do
      double('player2', 
        welcome: nil, 
        assign_name: nil, 
        assign_symbol: nil,
      )
    end

    before do
      new_game.instance_variable_set(:@board, board)
      new_game.instance_variable_set(:@player1, player1)
      new_game.instance_variable_set(:@player2, player2)
      allow(new_game).to receive(:play_game)
    end

    it 'calls assign_name on @player1' do
      expect(player1).to receive(:assign_name)
      new_game.start_game
    end

    it 'calls #assign symbol on @player1' do
      expect(player1).to receive(:assign_symbol)
      new_game.start_game
    end

    it 'calls #assign_name on @player2' do
      expect(player2).to receive(:assign_name)
      new_game.start_game
    end

    it 'calls #assign_symbol on @player2' do
      expect(player2).to receive(:assign_symbol)
      new_game.start_game
    end
  end

  describe '#play game' do
    subject(:game) { described_class.new }

    it 'ends loop when there is a win' do
      board = game.instance_variable_get(:@board)
      allow(board).to receive(:tie?).and_return(false)
      allow(board).to receive(:win?).and_return(true)
      expect(game).to receive(:end_game)
      game.play_game
    end
    
    it 'ends loop when there is a tie' do
      board = game.instance_variable_get(:@board)
      allow(board).to receive(:win?).and_return(false)
      allow(board).to receive(:tie?).and_return(true)
      expect(game).to receive(:end_game)
      game.play_game
    end

    it 'ends loop after several turns' do
      board = game.instance_variable_get(:@board)
      allow(board).to receive(:win?).and_return(false, false, true)
      allow(board).to receive(:tie?).and_return(false)
      expect(game).to receive(:end_game)
      game.play_game
    end
  end
end
