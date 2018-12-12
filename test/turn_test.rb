require 'minitest/autorun'
require 'minitest/pride'
require './lib/turn'

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
    boards = "=============COMPUTER BOARD=============\n  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n==============PLAYER BOARD==============\n  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n"
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

  def test_it_can_report_the_computer_results
    player_board = Board.new
    computer_board = Board.new
    turn = Turn.new(player_board, computer_board)
    turn.computer_fire_shot("A1")
    turn.computer_coordinate = 'A1'
    submarine = Ship.new('Submarine', 2)
    player_board.place(submarine, ['A2','A3'])
    turn.computer_fire_shot('A2')
    assert_equal 'My shot on A1 was a miss.', turn.report_computer_results
    turn.computer_coordinate = 'A2'
    assert_equal 'My shot on A2 was a hit.', turn.report_computer_results
    turn.computer_coordinate = 'A3'
    turn.computer_fire_shot('A3')
    assert_equal 'My shot on A3 sunk your Submarine.', turn.report_computer_results
  end

  def test_it_can_report_the_player_results
    player_board = Board.new
    computer_board = Board.new
    submarine = Ship.new('Submarine', 2)
    computer_board.place(submarine, ['A1', 'A2'])
    turn = Turn.new(player_board, computer_board)
    turn.player_fire_shot("A1")
    turn.player_coordinate = 'A1'
    assert_equal 'Your shot on A1 was a hit.', turn.report_player_results
    turn.player_coordinate = 'B2'
    turn.player_fire_shot('B2')
    assert_equal 'Your shot on B2 was a miss.', turn.report_player_results
    turn.player_coordinate = 'A2'
    turn.player_fire_shot('A2')
    assert_equal 'Your shot on A2 sunk my Submarine.', turn.report_player_results
  end
end
