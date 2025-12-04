# main.rb
require_relative 'tic_tac_toe'

# instructions
puts 'Welcome to Tic-Tac-Toe!'
puts 'Each turn, enter two numbers with a space, per the grid layout below:'
puts "\r\n"
puts '0 0 | 0 1 | 0 2'
puts '1 0 | 1 1 | 1 2'
puts '2 0 | 2 1 | 2 2'
puts "\r\n"

# instantiate Game and execute play game
game = Game.new
game.play_game
