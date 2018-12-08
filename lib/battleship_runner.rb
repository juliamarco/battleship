require './lib/ship'
require './lib/board'
require './lib/cell'
require './lib/game_setup'
require './lib/turn'
require 'pry'

player_board = Board.new
computer_board = Board.new
turn = Turn.new(player_board, computer_board)
game = GameSetup.new(turn)
game.main_menu
