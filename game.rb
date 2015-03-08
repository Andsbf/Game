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

attr_accessor :gamers, :active_players, :current_player_index, :round_index, :num_players 
  
  def initialize
    @gamers = []
    @active_players = []
    @current_player_index = 0
    @round_index = 0
    @num_players = 0
  end

  def create_player
    player_name_input = nil
    p "Player #{gamers.length + 1} name:"  

    while player_name_input == "" or player_name_input == nil
    player_name_input = gets.chomp  
    end
        player_name_input = Player.new(player_name_input)
    @gamers << player_name_input
    @active_players  << player_name_input
    
  end

  def sets

    while @num_players == 0
      p "How many people will play?"
      @num_players = Integer(gets) rescue nil
      @num_players = 0 if @num_players.class != Fixnum 
    end

    while @round_index == 0
      p "Number of rounds to be played?"
      @round_index = Integer(gets)*2 rescue nil
      @round_index = 0 if @round_index.class != Fixnum  
      @round_index = 0 unless @round_index.even? 
    end
  end

  def round
    
    right_answer = self.question
    user_input = self.user_answer
    result = user_input == right_answer
    result ? current_player.score += 1 : current_player.lives -= 1 
    sleep (1)
    result
  end

  def update 
    @round_index -= 1
    @current_player_index == (active_players.length - 1) ? @current_player_index = 0 : @current_player_index += 1 
    @active_players = gamers.select{|x| x.lives > 0}
  end

  def current_player 
    active_players[current_player_index]
  end

  def pick_winner #return String with winner phrase

    winner = active_players.sort_by{|x| [x.score, x.lives]}.reverse
    
    if winner.length > 1
      [winner[0].score,winner[0].lives] == [winner[1].score,winner[1].lives] ? "It is a draw" : ( winner.first.name + " is the winner!!!" ) 
    else
      winner.first.name + " is the winner!!!"
    end

  end

  def rules
    puts "Game Rule:\nEach player has 4 seconds to answer each question!!!"
    p "Ready?(Press ENTER to continue)"
    gets
  end

  def question
    num1, num2 = rand(1..20) , rand(1..20)
    op = ['+','-','*','/'][rand(4)]
    
    puts "\n#{current_player.name}, What does #{num1} #{op} #{num2}  is equal?\n"
    num1.method(op).(num2)
    
  end

  def user_answer
    answer = Timeout::timeout(4){gets.chomp} rescue nil 
    p "Timeout" if answer == nil
    answer.to_i
  end
end

