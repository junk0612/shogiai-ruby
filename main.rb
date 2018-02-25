require 'shogi'
require 'pry'

require './lib/brain'
require './lib/ext/shogi'

game = Shogi::Game.new(:csa)
brain = Brain.new

loop do
  puts game.to_csa

  input = gets
  game.move("+#{input}") rescue next

  break if game.end?

  brain.move(game)

  break if game.end?
end

puts game.to_csa
File.open("log/#{Time.now.strftime('%Y%m%d%H%M%S%L')}.txt", 'w') do |file|
  file.write(game.kifu)
end
