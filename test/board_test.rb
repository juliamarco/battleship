require './lib/board'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'

class BoardTest < Minitest::Test

  def test_it_exists

    board = Board.new

  assert_instance_of Board, board
  end

  def test_valid_coordinates

    board = Board.new

  assert_equal true, board.valid_coordinate?("A1")
  end

  def test_invalid_coordinates

    board = Board.new

  assert_equal false, board.valid_coordinate?("E1")
  end

  def test_number_of_coordinates_equals_length

    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

  assert_equal true, board.valid_placement?(submarine, ["A1", "A2"])
  assert_equal false, board.valid_placement?(cruiser, ["A1", "A2"])
  end

  def test_coordinates_are_consecutive

    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

  assert_equal false, board.valid_placement?(cruiser, ["A1", "A1", "A2"])
  assert_equal true, board.valid_placement?(submarine, ["A1", "A2"])
end

end
