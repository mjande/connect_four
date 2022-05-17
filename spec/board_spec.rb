# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  describe '#create' do
    subject(:new_board) { described_class.new }

    it 'creates hash containing board data' do
      expect(new_board.data_array).to eq(
        [[nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil]]
      )
    end
  end

  describe '#display' do
    subject(:new_board) { described_class.new }

    it 'prints blank board display' do
      expect { new_board.display }.to output(
        "|   |   |   |   |   |   |   |\n" \
        "-----------------------------\n" \
        "|   |   |   |   |   |   |   |\n" \
        "-----------------------------\n" \
        "|   |   |   |   |   |   |   |\n" \
        "-----------------------------\n" \
        "|   |   |   |   |   |   |   |\n" \
        "-----------------------------\n" \
        "|   |   |   |   |   |   |   |\n" \
        "-----------------------------\n" \
        "|   |   |   |   |   |   |   |\n" \
        "-----------------------------\n"
      ).to_stdout
    end

    it 'prints partially filled board with correct positions' do
      new_board.add_piece(0, 0, '○')
      new_board.add_piece(4, 0, '●')
      new_board.add_piece(6, 0, '○')
      new_board.add_piece(4, 1, '●')
      new_board.add_piece(5, 0, '○')
      new_board.add_piece(4, 2, '●')
      new_board.add_piece(5, 1, '○')
      expect { new_board.display }.to output(
        "|   |   |   |   |   |   |   |\n" \
        "-----------------------------\n" \
        "|   |   |   |   |   |   |   |\n" \
        "-----------------------------\n" \
        "|   |   |   |   |   |   |   |\n" \
        "-----------------------------\n" \
        "|   |   |   |   | ● |   |   |\n" \
        "-----------------------------\n" \
        "|   |   |   |   | ● | ○ |   |\n" \
        "-----------------------------\n" \
        "| ○ |   |   |   | ● | ○ | ○ |\n" \
        "-----------------------------\n"
      ).to_stdout
    end
  end

  describe '#find_empty_row' do
    subject(:board) { described_class.new }
    let(:player) { double('player', turn_input: 0) }

    before do
      allow(board).to receive(:puts)
    end

    it 'returns row 0 in an empty column' do
      expect(board.find_empty_row(0, player)).to eq([0, 0])
    end

    it 'returns row 3 in a column with three pieces' do
      board.add_piece(1, 0, '○')
      board.add_piece(1, 1, '○')
      board.add_piece(1, 2, '○')
      expect(board.find_empty_row(1, player)).to eq([1, 3])
    end

    it 'sends #turn_input to @player in a full column' do
      0.upto(5) { |row| board.add_piece(3, row, '○') }
      expect(player).to receive(:turn_input)
      board.find_empty_row(3, player)
    end
  end

  describe '#add_piece' do
    context 'the indicated column is empty' do
      subject(:new_board) { described_class.new }

      it 'adds a white piece' do
        new_board.add_piece(0, 0, '○')
        expect(new_board.data_array[0][0]).to eq('○')
      end

      it 'adds a black piece' do
        new_board.add_piece(0, 0, '●')
        expect(new_board.data_array[0][0]).to eq('●')
      end
    end

    context 'the indicated column is completely filled' do
      subject(:filled_board) { described_class.new }

      it 'does not change the filled spot' do
        6.times { |row| filled_board.add_piece(0, row, '○') }
        filled_board.add_piece(0, 0, '●')
        expect(filled_board.data_array[0][5]).to be('○')
      end
    end
  end

  describe '#win?' do
    context 'there is a row win' do
      subject(:row_win) { described_class.new }

      before do
        row_win.add_piece(0, 0, '○')
        row_win.add_piece(1, 0, '○')
        row_win.add_piece(2, 0, '○')
        row_win.add_piece(3, 0, '○')
      end

      context 'to the left of the original position' do
        it 'returns true' do
          expect(row_win.win?(3, 0)).to be_truthy
        end
      end

      context 'to the right of original position' do
        it 'returns true' do
          expect(row_win.win?(0, 0)).to be_truthy
        end
      end

      context 'on either side of original position' do
        subject(:mid_row_win) { described_class.new }

        it 'returns true' do
          expect(row_win.win?(2, 0)).to be_truthy
        end
      end
    end

    context 'there is a column win' do
      subject(:col_win) { described_class.new }

      before do
        col_win.add_piece(3, 0, '○')
        col_win.add_piece(3, 1, '○')
        col_win.add_piece(3, 2, '○')
        col_win.add_piece(3, 3, '○')
      end

      it 'returns true' do
        expect(col_win.win?(3, 3)).to be_truthy
      end
    end

    context 'there is a left diagonal win' do
      subject(:diag_win) { described_class.new }

      before do
        diag_win.add_piece(1, 0, '●')
        diag_win.add_piece(1, 1, '●')
        diag_win.add_piece(1, 2, '●')
        diag_win.add_piece(2, 0, '●')
        diag_win.add_piece(2, 1, '●')
        diag_win.add_piece(3, 0, '●')
        diag_win.add_piece(1, 3, '○')
        diag_win.add_piece(2, 2, '○')
        diag_win.add_piece(3, 1, '○')
        diag_win.add_piece(4, 0, '○')
      end

      context 'from bottom of diagonal' do
        it 'returns true' do
          expect(diag_win.win?(4, 0)).to be_truthy
        end
      end

      context 'from top of diagonal' do
        it 'returns true' do
          expect(diag_win.win?(1, 3)).to be_truthy
        end
      end

      context 'from middle of diagonal' do
        it 'returns true' do
          expect(diag_win.win?(2, 2)).to be_truthy
        end
      end
    end

    context 'there is a right diagonal win' do
      subject(:diag_win) { described_class.new }

      before do
        diag_win.add_piece(2, 0, '●')
        diag_win.add_piece(3, 0, '●')
        diag_win.add_piece(3, 1, '●')
        diag_win.add_piece(4, 0, '●')
        diag_win.add_piece(4, 1, '●')
        diag_win.add_piece(4, 2, '●')
        diag_win.add_piece(1, 0, '○')
        diag_win.add_piece(2, 1, '○')
        diag_win.add_piece(3, 2, '○')
        diag_win.add_piece(4, 3, '○')
      end

      context 'from bottom of diagonal' do
        it 'returns true' do
          expect(diag_win.win?(1, 0)).to be_truthy
        end
      end

      context 'from top of diagonal' do
        it 'returns true' do
          expect(diag_win.win?(4, 3)).to be_truthy
        end
      end

      context 'from middle of diagonal' do
        it 'returns true' do
          expect(diag_win.win?(2, 1)).to be_truthy
        end
      end
    end

    context 'there is no win from position' do
      context 'the rest of the board is blank' do
        subject(:blank_board) { described_class.new }

        it 'returns false' do
          blank_board.add_piece(3, 0, '○')
          expect(blank_board.win?(3, 0)).to be_falsey
        end
      end

      context 'there are other pieces on the board' do
        subject(:partial_board) { described_class.new }

        it 'returns false' do
          4.times { |col| partial_board.add_piece(col, 0, '●') }
          partial_board.add_piece(4, 0, '○')
          expect(partial_board.win?(4, 0)).to be_falsey
        end
      end
    end
  end

  describe '#tie?' do
    context 'the board is full' do
      subject(:full_board) { described_class.new }

      before do
        7.times do |col|
          6.times do |row|
            mid_rows = [2, 3]
            symbol =
              if mid_rows.include?(col)
                row.even? ? '○' : '●'
              else
                row.odd? ? '○' : '●'
              end
            full_board.add_piece(col, row, symbol)
          end
        end
      end

      it 'returns true' do
        expect(full_board.tie?).to be_truthy
      end
    end

    context 'the board is not full and a win is still possible' do
      subject(:partial_board) { described_class.new }

      it 'returns false' do
        expect(partial_board.tie?).to be_falsey
      end
    end
  end
end
