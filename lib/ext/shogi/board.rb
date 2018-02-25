module Shogi
  class Board
    attr_reader :captured
    FU = [0, 50]
    KY = [100, 120]
    KE = [500, 550]
    GI = [600, 660]
    KI = [800, 880]
    KA = [900, 990]
    HI = [1000, 1100]
    OU = [10000000, 100000000]
    TO = [1100]
    NY = [1000]
    NK = [1000]
    NG = [900]
    UM = [1500]
    RY = [1700]

    def evaluation_value
      total_value = 0
      @table.each do |row|
        row.each do |cell|
          next if cell == ''

          value = Shogi::Board.const_get(cell[1..2])[0]
          value *= -1 if cell[0] == '-'

          total_value += value
        end
      end

      @captured.each do |piece|
        value = Shogi::Board.const_get(piece[1..2])[1]
        value *= -1 if piece[0] == '-'

        total_value += value
      end

      total_value
    end
  end
end
