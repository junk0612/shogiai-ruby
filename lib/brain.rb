class Brain
  def move(shogi_game)
    movables = think(shogi_game, '-')
    shogi_game.move(movables.sample[0])
  end

  def think(shogi_game, phase)
    result = []
    (0..9).each do |b_x|
      (0..9).each do |b_y|
        (1..9).each do |e_x|
          (1..9).each do |e_y|
            %w(FU KY NY KE NK GI NG KI KA UM HI RY OU).each do |koma|
              movable = "#{phase}#{b_x}#{b_y}#{e_x}#{e_y}#{koma}"
              board = Marshal.load(Marshal.dump(shogi_game.board))
              board.move(movable) rescue next

              puts movable, board.evaluation_value
              result << [movable, board, board.evaluation_value]
            end
          end
        end
      end
    end

    result.sort! {|item| item[2] }
    result.reverse! if phase == '+'

    puts result
    result.select {|item| item[2] == result.first[2] }
  end
end
