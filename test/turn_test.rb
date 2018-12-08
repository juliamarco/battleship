require 'minitest/autorun'
require './lib/turn'

class TurnTest < Minitest::Test
  def test_it_exists
    turn = Turn.new
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
    p turn.display_boards

end
