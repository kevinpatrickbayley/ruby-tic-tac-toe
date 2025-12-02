class Game
  @@turn_count = 1
  @@winner = ''

  def initialize
    puts 'Player 1, enter your name!'
    @player_one_name = gets.chomp
    puts 'Player 2, enter your name!'
    @player_two_name = gets.chomp
    @board = Array.new(3){Array.new(3,'*')}
  end

end

#instructions
puts 'Welcome to Tic-Tac-Toe!'
puts 'Each turn, enter two numbers with a space, per the grid layout below:'
puts "\r\n"
puts '0 0 | 0 1 | 0 2'
puts '1 0 | 1 1 | 1 2'
puts '2 0 | 2 1 | 2 2'
puts "\r\n"