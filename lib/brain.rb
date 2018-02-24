class Brain
  def move(shogi_game)
    catch :outer do
      (1..9).each do |b_x|
        (1..9).each do |b_y|
          (1..9).each do |e_x|
            (1..9).each do |e_y|
              %w(FU KY NY KE NK GI NG KI KA UM HI RY OU).each do |koma|
                shogi_game.move("-#{b_x}#{b_y}#{e_x}#{e_y}#{koma}") rescue next
                throw :outer
              end
            end
          end
        end
      end
    end
  end
end
