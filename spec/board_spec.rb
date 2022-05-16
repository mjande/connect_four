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
      new_board.add_piece(0, '○')
      new_board.add_piece(4, '●')
      new_board.add_piece(6, '○')
      new_board.add_piece(4, '●')
      new_board.add_piece(5, '○')
      new_board.add_piece(4, '●')
      new_board.add_piece(5, '○')
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

  describe '#add_piece' do
    context 'the indicated column is empty' do
      subject(:new_board) { described_class.new }

      it 'adds a white piece to an empty column' do
        new_board.add_piece(0, '○')
        expect(new_board.data_array[0][0]).to eq('○')
      end

      it 'adds a black piece to an empty column' do
        new_board.add_piece(0, '●')
        expect(new_board.data_array[0][0]).to eq('●')
      end
    end

    context 'the indicated column is partially filled' do
      subject(:partial_board) { described_class.new }

      it 'adds piece to next available row' do
        partial_board.add_piece(0, '○')
        partial_board.add_piece(0, '●')
        expect(partial_board.data_array[0][1]).to eq('●')
      end
    end

    context 'the indicated column is completely filled' do
      subject(:filled_board) { described_class.new }

      it 'does not change the filled spot' do
        6.times { filled_board.add_piece(0, '○') }
        filled_board.add_piece(0, '●')
        expect(filled_board.data_array[0][5]).not_to be('●')
      end
    end
  end

  describe '#win?' do
    context 'there is a row win' do
      subject(:row_win) { described_class.new }

      before do
        row_win.add_piece(0, '○')
        row_win.add_piece(1, '○')
        row_win.add_piece(2, '○')
        row_win.add_piece(3, '○')
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
        4.times { col_win.add_piece(3, '○') }
      end

      it 'returns true' do
        expect(col_win.win?(3, 3)).to be_truthy
      end
    end

    context 'there is a left diagonal win' do
      subject(:diag_win) { described_class.new }

      before do
        1.upto(3) { |col| diag_win.add_piece(col, '●') }
        1.upto(2) { |col| diag_win.add_piece(col, '●') }
        diag_win.add_piece(1, '●')
        1.upto(4) { |col| diag_win.add_piece(col, '○') }
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
        2.upto(4) { |col| diag_win.add_piece(col, '●') }
        3.upto(4) { |col| diag_win.add_piece(col, '●') }
        diag_win.add_piece(4, '●')
        1.upto(4) { |col| diag_win.add_piece(col, '○') }
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
          blank_board.add_piece(3, '○')
          expect(blank_board.win?(3, 0)).to be_falsey
        end
      end

      context 'there are other pieces on the board' do
        subject(:partial_board) { described_class.new }

        it 'returns false' do
          4.times { |col| partial_board.add_piece(col, '●') }
          partial_board.add_piece(4, '○')
          expect(partial_board.win?(4, 0)).to be_falsey
        end
      end
    end
  end

  describe '#tie?' do
    context 'the board is full' do
      subject(:full_board) { described_class.new }

      before do
        2.times do
          col = 0
          4.times do
            full_board.add_piece(col, '○')
            col += 2
          end
          col = 1
          3.times do
            full_board.add_piece(col, '●')
            col += 2
          end
        end
        2.times do
          col = 0
          4.times do
            full_board.add_piece(col, '●')
            col += 2
          end
          col = 1
          3.times do
            full_board.add_piece(col, '○')
            col += 2
          end
        end
        2.times do
          col = 0
          4.times do
            full_board.add_piece(col, '○')
            col += 2
          end
          col = 1
          3.times do
            full_board.add_piece(col, '●')
            col += 2
          end
        end
      end

      it 'returns true' do
        expect(full_board.tie?).to be_truthy
      end
    end
  end
end
