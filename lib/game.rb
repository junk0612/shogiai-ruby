module Shogi
  class Board
    attr_reader :captured
  end

  class Game
    def end?
      @board.captured.any? {|piece| piece.include?('OU') }
    end
  end
end
