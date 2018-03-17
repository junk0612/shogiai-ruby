module Shogiban
  class Move
    attr_accessor :piece, :to, :promote

    def initialize(piece, to, promote)
      @piece = piece
      @to = to
      @promote = promote
    end

    def to_csa
      "#{piece.turn}#{piece.place.to_csa}#{to.to_csa}#{piece.piece_name}"
    end
  end
end
