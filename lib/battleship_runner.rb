require './lib/ship'
require './lib/board'
require './lib/cell'
require './lib/game_setup'
require './lib/turn'

player_board = Board.new
#creates default board(4x4)
computer_board = Board.new
#creates default board(4x4)
turn = Turn.new(player_board, computer_board)
game = GameSetup.new(turn)
game.main_menu
