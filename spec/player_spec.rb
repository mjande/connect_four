# frozen_string_literal: true

require_relative '../lib/player'

describe Player do
  describe '#assign_name' do
    subject(:new_player) { described_class.new }

    it 'assigns name to @name' do
      allow(new_player).to receive(:puts)
      allow(new_player).to receive(:gets).and_return('Harry')
      new_player.assign_name(1)
      expect(new_player.instance_variable_get(:@name)).to eq('Harry')
    end
  end

  describe '#assign_symbols' do
    context 'when assigning player 1' do
      subject(:player1) { described_class.new }

      it 'stores ○ as @symbol' do
        allow(player1).to receive(:puts)
        player1.assign_symbol(1)
        expect(player1.instance_variable_get(:@symbol)).to eq('○')
      end
    end

    context 'when assigning player 2' do
      subject(:player2) { described_class.new }

      it 'stores ● as @symbol' do
        allow(player2).to receive(:puts)
        player2.assign_symbol(2)
        expect(player2.instance_variable_get(:@symbol)).to eq('●')
      end
    end
  end

  describe '#turn_input' do
    subject(:player) { described_class.new }

    before do
      allow(player).to receive(:puts)
    end

    it 'returns player input' do
      allow(player).to receive(:gets).and_return(0)
      expect(player.turn_input(1)).to eq(0)
    end

    it 'loops until a valid response is returned' do
      allow(player).to receive(:gets).and_return(-10, 8, 4)
      expect(player.turn_input(1)).to eq(4)
    end
  end

  describe '#play_again?' do
    subject(:finished_game) { described_class.new }

    before do
      allow(finished_game).to receive(:puts)
    end

    it 'returns true if the player wants to play again' do
      allow(finished_game).to receive(:gets).and_return('Y')
      expect(finished_game.play_again?).to be_truthy
    end

    it 'returns false if the player does not want to play again' do
      allow(finished_game).to receive(:gets).and_return('N')
      expect(finished_game.play_again?).to be_falsey
    end

    it 'loops if the user does not give a valid reponse' do
      allow(finished_game).to receive(:gets).and_return('a', 'N')
      expect(finished_game.play_again?).to be_falsey
    end
  end
end
