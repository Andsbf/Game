class Players
  
  attr_accessor :name, :score, :lives
  @@population =[]
  def initialize(name)  
    # Instance variables  
    @name = name  
    @lives = 3
    @score = 0
    @@population << self
    
  end  
  
  def self.population
    @@population
  end


  def turn

    num1 = rand(1..20)
    num2 = rand (1..20)
    op = ['+','-','*','/'][rand(4)]
    puts "\n#{@name}, What does #{num1} #{op} #{num2}  is equal?\n"
    right_answer = num1.method(op).(num2)  

    user_input = nil
    while user_input.nil?
      user_input = Integer(gets) rescue nil
    end
    user_input == right_answer ? @score =+ 1 : @lives -= 1 
    
  end  
  
  def display
     
    puts "\nPlayer:#{@name} ; Lives: #{@lives}; Score: #{@score}\n"

  end  

  def self.active
    @@population.select{|p| p.lives > 0 }
  end
end 

