require './lib/shogiban/piece/base'

module Shogiban
  module Piece
    class FU < Base
      MOVEMENTS = [[0, 1]]
    end

    class KY < Base
      MOVEMENTS = (1..8).map {|height| [0, height] }
    end

    class KE < Base
      MOVEMENTS = [[1, 2], [-1, 2]]
    end

    class GI < Base
      MOVEMENTS = [[-1, 1], [0, 1], [1, 1], [-1, -1], [1, -1]]
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
