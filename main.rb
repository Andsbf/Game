
require './game.rb'
require 'pry'

game_1 = Game.new
game_1.sets
game_1.num_players.times {game_1.create_player}

while ( game_1.active_players.length > 1 ) && ( game_1.round_index > 0 ) 

  result = game_1.round
  game_1.update
  game_1.gamers.each{ |g| g.display } unless result

end
puts "\nGAME FINAL SCORE\n"

game_1.gamers.each{ |g| g.display } unless game_1.active_players.length < 1
p game_1.pick_winner


  