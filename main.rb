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

  def player_turn(turn)
    if turn.odd?
      player_choice(@player_one_name, '0')
    else
      player_choice(@player_two_name, 'X')
    end
  end

  def player_choice(player, symbol)
    puts "#{player} please enter your coorinates seperated byy a space."
    input = gets.chomp
    input_array = input.split
    coord_one = input_array[0].to_i
    coord_two = input_array[1].to_i

    # loop unitl the user input is valid - has space, between 0 and 2, board slot is free
    until input.match(/\s/) && coord_one.between(0, 2) && coord_two.between(0, 2) && @board[coord_one][coord_two] == '*'
            puts "Please enter valid coordinates for an empty space in the grid"
            input = gets.chomp
            input_array = input.split
            coord_one = input_array[0].to_i
            coord_two = input_array[1].to_i
    end 

    add_to_board(coord_one, coord_two, symbol)
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