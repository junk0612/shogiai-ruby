module Shogiban
  class Cell
    attr_reader :x, :y

    def initialize(x, y)
      @x = x
      @y = y
    end

    def out_of_board?
      !(1..9).include?(@x) || !(1..9).include?(@y)
    end

    def to_csa
      "#{@x}#{@y}"
    end
  end
end
