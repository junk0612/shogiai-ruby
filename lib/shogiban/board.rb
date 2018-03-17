require './lib/shogiban/piece'
require './lib/shogiban/cell'
require './lib/shogiban/move'

module Shogiban
  class Board
    attr_reader :pieces, :table, :captured

    def initialize
      @captured = {'+' => [], '-' => []}
      @pieces = []
      @table = [[nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil], ]
      initialize_placement_of_pieces
    end

    def move(move)
      if piece = @table[move.to.x][move.to.y]
        piece.capture
        @captured[move.piece.turn] << piece
      end

      if move.piece.captured
        move.piece.captured = false
        @captured[move.piece.turn] -= [move.piece]
      else
        @table[move.piece.place.x][move.piece.place.y] = nil
      end

      @table[move.to.x][move.to.y] = move.piece
      move.piece.place = move.to
    end

    def to_csa
      result = []

      (1..9).each do |row|
        str = "P#{row}"
        (1..9).to_a.reverse.each do |column|
          if piece = @table[column][row]
            str << piece.to_csa
          else
            str << ' * '
          end
        end
        result << str
      end

      cap_first = 'P+'
      @captured['+'].each do |piece|
        cap_first << piece.to_csa
      end
      result << cap_first

      cap_second = 'P-'
      @captured['-'].each do |piece|
        cap_second << piece.to_csa
      end
      result << cap_second

      result.join("\n")
    end

    def movables(turn)
      @pieces.select {|piece| piece.turn == turn }.reduce([]) do |result, piece|
        result.concat piece.movables
      end
    end

    def at?(x, y, turn = '+-')
      piece = @table[x][y]
      !piece.nil? && turn.include?(piece.turn)
    end

    def no_other_pieces?(bx, by, ex, ey)
      if bx == ex
        (Math.min(by, ey)+1..Math.max(by, ey)-1).none? do |y|
          at?(start[0], y)
        end
      elsif by == ey
        (Math.min(bx, ex)+1..Math.max(by, ey)-1).none? do |x|
          at?(x, start[1])
        end
      elsif bx > ex && by < ey
        (1..start[1]-start[0]-1)
      end
    end

    private

    def initialize_placement_of_pieces
      parse_table(default_table)
    end

    def parse_table(table)
      table.each_line(chomp: true).with_index(1) do |line, row|
        (1..9).each do |column|
          csa = line[3 * (column - 1), 3]
          next if csa[1] == '*'

          piece = parse_piece(csa)
          piece.place = Cell.new(column, row)
          @pieces << piece
          @table[column][row] = piece
        end
      end
    end

    def parse_piece(csa)
      Shogiban::Piece.const_get(csa[1..2]).new(csa[0])
    end

    def default_table
      <<~TABLE
      -KY-KE-GI-KI-OU-KI-GI-KE-KY
       * -HI *  *  *  *  * -KA *
      -FU-FU-FU-FU-FU-FU-FU-FU-FU
       *  *  *  *  *  *  *  *  *
       *  *  *  *  *  *  *  *  *
       *  *  *  *  *  *  *  *  *
      +FU+FU+FU+FU+FU+FU+FU+FU+FU
       * +KA *  *  *  *  * +HI *
      +KY+KE+GI+KI+OU+KI+GI+KE+KY
      TABLE
    end
  end
end
