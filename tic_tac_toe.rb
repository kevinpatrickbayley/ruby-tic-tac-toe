# frozen_string_literal: true

# Game manages a console Tic-Tac-Toe match between two players.
# It handles board display, input, turn sequencing, and win/draw detection.
class Game
  attr_accessor :turn_count, :winner

  def initialize
    puts 'Player 1, enter your name!'
    @player_one_name = gets.chomp
    puts 'Player 2, enter your name!'
    @player_two_name = gets.chomp
    @board = Array.new(3) { Array.new(3, '*') }
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
    val.nil? ? ' ' : val # or mapping if you store something else
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
    until input.match(/\s/) && coord_one.between?(0,
                                                  2) && coord_two.between?(0, 2) && @board[coord_one][coord_two] == '*'
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

  def three_across
    @board.each do |i|
      if i.all? { |j| j == 'X' }
        @winner = 'X'
        @turn_count = 10
      elsif i.all? { |j| j == 'O' }
        @winner = '0'
        @turn_count = 10
      end
    end
  end

  def three_down
    flat = @board.flatten
    flat.each_with_index do |v, i|
      if v == 'X' && flat[i + 3] == 'X' && flat[i + 6] == 'X'
        @winner = 'X'
        @turn_count = 10
      elsif v == 'O' && flat[i + 3] == 'O' && flat[i + 6] == 'O'
        @winner = 'O'
        @turn_count = 10
      end
    end
  end

  def three_diagonal
    center_val = @board[1][1]
    return unless %w[X O].include?(center_val)

    if @board[0][0] && @board[2][2] == center_val
      @winner = center_val
      @turn_count = 10
    elsif @board[2][0] && @board[0][2] == center_val
      @winner = center_val
      @turn_count = 10
    end
  end

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
      three_across
      three_down
      three_diagonal
      display_board(@board)
    end

    declare_result(@winner)
  end
end
