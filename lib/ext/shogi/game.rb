module Shogi
  class Game
    attr_reader :board
    def end?
      @board.captured.any? {|piece| piece.include?('OU') }
    end
  end
end
