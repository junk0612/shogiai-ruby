module Shogiban
  class Move
    attr_accessor :piece, :to, :promote

    def initialize(piece, to, promote)
      @piece = piece
      @to = to
      @promote = promote
    end
  end
end
