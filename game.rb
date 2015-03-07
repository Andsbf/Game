require 'timeout'

class Player
  
  attr_accessor :name, :score, :lives

  def initialize(name)  
    # Instance variables  
    @name = name  
    @lives = 3
    @score = 0
    
    
  end  
  
  def display
     
    puts "\nPlayer:#{@name} => Lives: #{@lives}; Score: #{@score}\n"

  end  

  
end 
##############################################################################################################################

class Game

  @@gamers = []
  @@active_players = []
  @@current_player_index = 0
  @@round_index = 0
  @@num_players = 0

  def initialize
  end

  def create_player
    p "Player #{@@gamers.length + 1} name:"  
    player_name_input = gets.chomp
    player_name_input = Player.new(player_name_input)
    @@gamers << player_name_input
    @@active_players  << player_name_input
  end

  def sets

    while @@num_players == 0
      p "How many people will play?"
      @@num_players = Integer(gets) rescue nil
      @@num_players = 0 if @@num_players.class != Fixnum 
    end

    while @@round_index == 0
      p "Number of rounds to be played?"
      @@round_index = Integer(gets)*2 rescue nil
      @@round_index = 0 if @@round_index.class != Fixnum  
      @@round_index = 0 unless @@round_index.even? 
    end
  end

  def round

    num1, num2 = rand(1..20) , rand(1..20)
    op = ['+','-','*','/'][rand(4)]
    
    puts "\n#{current_player.name}, What does #{num1} #{op} #{num2}  is equal?\n"
    right_answer = num1.method(op).(num2)  


    user_input = Timeout::timeout(5){gets.chomp} rescue nil 

    # user_input = nil
    # while user_input.nil?
    #   user_input = Integer(gets) rescue nil
    # end
    
    result = user_input.to_i == right_answer
    result ? current_player.score += 1 : current_player.lives -= 1 
    result
  end

  def update
    @@round_index -= 1
    @@current_player_index == (@@active_players.length - 1) ? @@current_player_index = 0 : @@current_player_index += 1 
    @@active_players = @@gamers.select{|x| x.lives > 0}
  end

  def current_player
    @@active_players[@@current_player_index]
  end

  def pick_winner

    winner = @@active_players.sort_by{|x| [x.score, x.lives]}.reverse
    
    if winner.length > 1
      [winner[0].score,winner[0].lives] == [winner[1].score,winner[1].lives] ? "It is a draw" : ( winner.first.name + " is the winner!!!" ) 
    else
      winner.first.name + " is the winner!!!"
    end

  end

  def round_index
    @@round_index
  end

  def gamers
    @@gamers
  end

  def active_players
    @@active_players
  end

  def num_players
    @@num_players
  end



end

