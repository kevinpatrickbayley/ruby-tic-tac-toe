# frozen_string_literal: true

# Game manages a console Tic-Tac-Toe match between two players.
# It handles board display, input, turn sequencing, and win/draw detection.
class Game
  attr_accessor :turn_count, :winner

  WIN_LINES = [
    [[0, 0], [0, 1], [0, 2]],  # row 0
    [[1, 0], [1, 1], [1, 2]],  # row 1
    [[2, 0], [2, 1], [2, 2]],  # row 2
    [[0, 0], [1, 0], [2, 0]],  # col 0
    [[0, 1], [1, 1], [2, 1]],  # col 1
    [[0, 2], [1, 2], [2, 2]],  # col 2
    [[0, 0], [1, 1], [2, 2]],  # diag
    [[0, 2], [1, 1], [2, 0]]   # anti-diag
  ].freeze

  def initialize
    puts 'Player 1, enter your name!'
    @player_one_name = gets.chomp
    puts 'Player 2, enter your name!'
    @player_two_name = gets.chomp
    @board = Array.new(3) { Array.new(3) }
    @turn_count = 1
    @winner = ''
  end

  # board display to console
  def display_board(board)
    puts "\r\n"
    puts row_line(board, 0)
    puts sep_line
    puts row_line(board, 1)
    puts sep_line
    puts row_line(board, 2)
    puts "\r\n"
  end

  # display_board helpers
  private

  def row_line(board, row)
    cells = board[row].map { |c| display_cell(c) }
    " #{cells[0]} | #{cells[1]} | #{cells[2]} "
  end

  def sep_line
    '---+---+---'
  end

  def display_cell(val)
    val.nil? ? ' ' : val
  end

  public

  def player_turn(turn)
    if turn.odd?
      player_choice(@player_one_name, 'O')
    else
      player_choice(@player_two_name, 'X')
    end
  end

  def player_choice(player, symbol)
    puts "#{player} please enter your coordinates seperated by a space."
    input = gets.chomp
    input_array = input.split
    coord_one = input_array[0].to_i
    coord_two = input_array[1].to_i

    # loop unitl the user input is valid - has space, between 0 and 2, board slot is free
    until input.match(/\s/) && coord_one.between?(0, 2) && coord_two.between?(0, 2) && @board[coord_one][coord_two].nil?
      puts 'Please enter valid coordinates for an empty space in the grid'
      input = gets.chomp
      input_array = input.split
      coord_one = input_array[0].to_i
      coord_two = input_array[1].to_i
    end

    add_to_board(coord_one, coord_two, symbol)
  end

  def add_to_board(coord_one, coord_two, symbol)
    @board[coord_one][coord_two] = symbol
    @turn_count += 1
  end

  # returns "X"/"O" or nil
  def find_winner
    WIN_LINES.each do |(r1, c1), (r2, c2), (r3, c3)|
      line = [@board[r1][c1], @board[r2][c2], @board[r3][c3]]
      if three_equal_filled?(line)
        @turn_count = 10
        @winner = line.first
      end
    end
    nil
  end

  # find_winner helper
  private

  def three_equal_filled?(cells)
    cells[0] && cells.uniq.size == 1
  end

  public

  def declare_result(symbol)
    case symbol
    when 'O'
      puts "#{@player_one_name} wins the game!"
    when 'X'
      puts "#{@player_two_name} wins the game!"
    else
      puts "It's a tie!"
    end
  end

  def play_game
    puts "\r\n"
    puts 'Here is your empty battlefield!'
    puts "\r\n"
    display_board(@board)
    puts "\r\n"

    until @turn_count >= 10
      player_turn(@turn_count)
      find_winner
      display_board(@board)
    end

    declare_result(@winner)
  end
end
