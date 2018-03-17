module Shogiban
  module Piece
    class Base
      attr_accessor :place, :turn, :captured

      def initialize(turn)
        @turn = turn
        @captured = false
      end

      def to_csa
        "#{@captured ? '00' : turn}#{piece_name}"
      end

      def piece_name
        self.class.name.split('::').last
      end

      def capture
        @captured = true
        @turn = @turn == '+' ? '-' : '+'
      end
    end
  end
end
