require './lib/board'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/cell'
require './lib/ship'
require 'pry'

class BoardTest < Minitest::Test
  def test_it_exists
    board = Board.new
    assert_instance_of Board, board
  end

  def test_valid_coordinates
    board = Board.new
    assert_equal true, board.valid_coordinate?('A1')
  end

  def test_invalid_coordinates
    board = Board.new
    assert_equal false, board.valid_coordinate?('E1')
  end

  def test_number_of_coordinates_equals_length
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    submarine = Ship.new('Submarine', 2)
    assert_equal true, board.valid_placement?(submarine, ['A1', 'A2'])
    assert_equal false, board.valid_placement?(cruiser, ['A1', 'A2'])
  end

  def test_coordinates_are_consecutive
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    submarine = Ship.new('Submarine', 2)
    assert_equal false, board.valid_placement?(cruiser, ['A1', 'A1', 'A2'])
    assert_equal true, board.valid_placement?(submarine, ['A1', 'A2'])
  end

  def test_coordinates_are_not_diagonal
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    assert_equal false, board.valid_placement?(cruiser, ['A1', 'B2', 'C3'])
  end

  def test_placement_is_valid
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    submarine = Ship.new('Submarine', 2)
    assert_equal true, board.valid_placement?(cruiser, ['B1', 'C1', 'D1'])
    assert_equal true, board.valid_placement?(submarine, ['A1', 'A2'])
  end

  def test_we_can_place_a_ship
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    board.place(cruiser, ['A1', 'A2', 'A3'])
    cell_1 = board.cells['A1']
    assert_instance_of Ship, cell_1.ship
  end

  def test_different_cells_contain_same_ship
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    board.place(cruiser, ['A1', 'A2', 'A3'])
    cell_1 = board.cells['A1']
    cell_2 = board.cells['A2']
    assert_equal cell_1.ship, cell_2.ship
  end

  def test_ships_cannot_overlap
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    board.place(cruiser, ['A1', 'A2', 'A3'])
    submarine = Ship.new('Submarine', 2)
    assert_equal false, board.valid_placement?(submarine, ['A1', 'B1'])
  end

  def test_board_can_render
    board = Board.new
    assert_equal '  1 2 3 4 \n' \
                 'A . . . . \n' \
                 'B . . . . \n' \
                 'C . . . . \n' \
                 'D . . . . \n', board.render
  end

  def test_board_can_render_optional_true
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    board.place(cruiser, ['A1', 'A2', 'A3'])
    assert_equal '  1 2 3 4 \n' \
                 'A S S S . \n' \
                 'B . . . . \n' \
                 'C . . . . \n' \
                 'D . . . . \n', board.render(true)
  end
end
