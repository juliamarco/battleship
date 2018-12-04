require './lib/board'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'

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

end
