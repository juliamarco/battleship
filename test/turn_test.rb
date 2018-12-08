require 'minitest/autorun'
require './lib/turn'
require 'minitest/pride'
require 'pry'

class TurnTest < Minitest::Test
  def test_it_exists
    player_board = Board.new
    computer_board = Board.new
    turn = Turn.new(player_board, computer_board)

    assert_instance_of Turn, turn
  end

  def test_it_can_display_boards
    player_board = Board.new
    computer_board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    submarine = Ship.new('Submarine', 2)
    player_board.place(cruiser, ['A1', 'A2', 'A3'])
    computer_board.place(submarine, ['A1','A2'])
    turn = Turn.new(player_board, computer_board)
    boards = "=============COMPUTER BOARD=============\n   1 2 3 4 \nA  . . . . \nB  . . . . \nC  . . . . \nD  . . . . \n==============PLAYER BOARD==============\n   1 2 3 4 \nA  S S S . \nB  . . . . \nC  . . . . \nD  . . . . \n"

    assert_equal boards, turn.display_boards
  end



  def test_player_fires_shots
    player_board = Board.new
    computer_board = Board.new
    turn = Turn.new(player_board, computer_board)
    turn.player_fire_shot('A1')

    assert_equal true, computer_board.cells['A1'].fired_upon?
  end


  def test_computer_fires_shots
    player_board = Board.new
    computer_board = Board.new
    turn = Turn.new(player_board, computer_board)
    turn.computer_fire_shot('A1')

    assert_equal true, player_board.cells['A1'].fired_upon?
  end
#
# test_it_can_report_the_results
#
# assert_equal, turn.report_results
# end
#
#
# if coordinate.valid_coordinate?(coordinate)

end
