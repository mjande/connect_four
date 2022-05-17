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
    let(:board) { double('board', add_piece: nil, find_empty_row: 0, display: nil) }
    let(:player1) { double('player1', turn_input: 0, symbol: '○', number: 1) }
    let(:player2) { double('player2', turn_input: nil, symbol: nil, number: 2) }

    before do 
      game.instance_variable_set(:@player1, player1)
      game.instance_variable_set(:@player2, player2)
    end
    
    it 'sends #add_piece to @board' do
      allow(board).to receive(:win?).and_return(true)
      game.instance_variable_set(:@board, board)
      allow(game).to receive(:end_game)
      expect(board).to receive(:add_piece).with(0, 0, '○')
      game.play_game
    end
    
    it 'ends loop when there is a win' do
      allow(board).to receive(:tie?).and_return(false)
      allow(board).to receive(:win?).and_return(true)
      game.instance_variable_set(:@board, board)
      expect(game).to receive(:end_game)
      game.play_game
    end
    
    it 'ends loop when there is a tie' do
      allow(board).to receive(:win?).and_return(false)
      allow(board).to receive(:tie?).and_return(true)
      game.instance_variable_set(:@board, board)
      expect(game).to receive(:end_game)
      game.play_game
    end

    it 'ends loop after several turns' do
      allow(board).to receive(:win?).and_return(false, false, true)
      allow(board).to receive(:tie?).and_return(false)
      game.instance_variable_set(:@board, board)
      expect(game).to receive(:end_game)
      game.play_game
    end
  end

  describe '#end_game' do
    subject(:end_game) { described_class.new }
    let(:player1) { double('player1', play_again?: true) }
    let(:player2) { double('player2', play_again?: false) }

    before do
      allow(end_game).to receive(:puts)
      allow(end_game).to receive(:start_game)
    end

    context 'player1 wins' do
      it 'sends #play_again? to @player1' do
        expect(player1).to receive(:play_again?)
        end_game.end_game(player1)
      end
    end

    context 'player2 wins' do
      it 'sends #play_again? to @player2' do
        expect(player2).to receive(:play_again?)
        end_game.end_game(player2)
      end
    end

    context 'when the player wants to play again' do
      it 'resets the board' do
        end_game.end_game(player1)
        board = end_game.instance_variable_get(:@board)
        expect(board.instance_variable_get(:@data_array)).to eq(Array.new(7) { Array.new(6) })
      end
    end
  end
end
