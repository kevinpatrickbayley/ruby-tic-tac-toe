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

  # blank board display to console
  def display_board(board)
    puts "\r"
    puts "#{board[0][0]} | #{board[0][1]} |#{board[0][2]}"
    puts "#{board[1][0]} | #{board[1][1]} |#{board[2][2]}"
    puts "#{board[2][0]} | #{board[2][1]} |#{board[2][2]}"
    puts "\r"
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