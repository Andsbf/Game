#main
require './game.rb'
require 'pry'



p "Player 1 name:"  
player_1_name = gets.chomp
player_1 = Players.new(player_1_name)

p "Player 2 name:"
player_2_name = gets.chomp
player_2 = Players.new(player_2_name)


rounds = 0
while rounds == 0
  p "Number of rounds to be played?(Only even numbers accepted)"
  rounds = Integer(gets) rescue nil
  rounds = 0 unless rounds.even? 
end

# binding.pry



1.upto(rounds) do |i|
  puts "ROUND : #{i}"
  
  Players.population.length.times do |j|
    player_b4_turn = Players.population[j].lives
    Players.population[j].turn 
    #binding.pry
    break if Players.population[j].lives == 0
    Players.population.each{|i| i.display} if player_b4_turn != Players.population[j].lives 
  end
  #binding.pry
  break  if Players.active.length < 2 
end
puts "\nGAME FINAL SCORE\n"
Players.population.each{|i| i.display}
