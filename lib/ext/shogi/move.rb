module Shogi
  class Move
    def initialize(from, to, piece, promote)
      @from = from
      @to = to
      @piece = piece
      @promote = promote
    end
  end
end
