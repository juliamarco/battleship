require './lib/ship'
require './lib/board'
require './lib/cell'
require './lib/game_setup'
require './lib/turn'
require 'pry'



=begin

end game
game reports who won
return to main menu

=end

player_board = Board.new
computer_board = Board.new
binding.pry
turn = Turn.new(player_board, computer_board)
game = GameSetup.new(turn)
game.main_menu
