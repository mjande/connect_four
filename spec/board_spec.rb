require_relative '../lib/board'

describe Board do
  describe '#create' do
    subject(:new_board) { described_class.new }
    
    it 'creates hash containing board data' do
      new_board.create
      board = new_board.instance_variable_get(:@data_array)
      expect(new_board.create).to eq(
        [[nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil],]
      )
    end
  end

  describe '#display' do
    subject(:new_board) { described_class.new }

    it 'prints blank board display' do
      new_board.create
      expect { new_board.display }.to output(
        "|   |   |   |   |   |   |   |\n" +
        "-----------------------------\n" +
        "|   |   |   |   |   |   |   |\n" +
        "-----------------------------\n" +
        "|   |   |   |   |   |   |   |\n" +
        "-----------------------------\n" +
        "|   |   |   |   |   |   |   |\n" +
        "-----------------------------\n" +
        "|   |   |   |   |   |   |   |\n" +
        "-----------------------------\n" +
        "|   |   |   |   |   |   |   |\n" +
        "-----------------------------\n"
      ).to_stdout
    end
  end
end