require './lib/shogiban/piece/base'

module Shogiban
  module Piece
    class FU < Base
      def movables
        [board.movable(0, @turn == '-' ? 1 : -1)]
      end
    end

    class KY < Base
      def movables
        board.movables(0, @turn == '-' ? 1 : -1)
      end
    end

    class KE < Base
      def movables
        [1, -1].reduce([]) do |result, x|
          result.concat board.movable(x, @turn == '-' ? 2 : -2)
        end
      end
    end

    class GI < Base
      def movables
        [[-1, 1], [0, 1], [1, 1], [-1, -1], [1, -1]].reduce([]) do |result, ary|
          x = ary[0]
          y = ary[1]
          result.concat board.movable(x, @turn == '-' ? y : -y)
        end
      end
    end

    class KI < Base
      MOVEMENTS = [[-1, 1], [0, 1], [1, 1], [-1, 0], [1, 0], [0, -1]]
    end

    class KA < Base
      MOVEMENTS = [(-8..-1).map {|a| [a, a] },
                   (1..8).map {|a| [a, a] },
                   (-8..-1).map {|a| [a, -a] },
                   (1..8).map {|a| [a, -a] }].flatten(1)
    end

    class HI < Base
      MOVEMENTS = [(-8..-1).map {|h| [0, h] },
                   (1..8).map {|h| [0, h] },
                   (-8..-1).map {|w| [w, 0] },
                   (1..8).map {|w| [w, 0] }].flatten(1)
    end

    class OU < Base
      MOVEMENTS = [[-1, -1], [0, -1], [1, -1], [1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0]]
    end
  end
end
