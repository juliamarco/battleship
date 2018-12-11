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
    assert_equal true, board.number_of_ordinates_equals_length(submarine, ['A1', 'A2'])
    assert_equal false, board.number_of_ordinates_equals_length(cruiser, ['A1', 'A2'])
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
    assert_equal false, board.valid_placement?(cruiser, ['A1', 'B1', 'B2'])
    assert_equal true, board.valid_placement?(submarine, ['A1', 'A2'])
    binding.pry
    assert_equal false, board.valid_placement?(submarine, ['F3', 'H7'])
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
    display = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
    assert_equal display, board.render
    #assign board to variable
  end

  def test_board_can_render_optional_true

    board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    board.place(cruiser, ['A1', 'A2', 'A3'])
    display = "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n"
    assert_equal display, board.render(true)
  end

  def test_board_can_render_with_hits

    board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    board.place(cruiser, ['A1', 'A2', 'A3'])
    board.cells["A3"].fire_upon
    display = "  1 2 3 4 \nA . . H . \nB . . . . \nC . . . . \nD . . . . \n"
    assert_equal display, board.render
  end

  def test_board_can_render_with_misses

    board = Board.new
    board.cells["A3"].fire_upon
    display = "  1 2 3 4 \nA . . M . \nB . . . . \nC . . . . \nD . . . . \n"
    assert_equal display, board.render
  end

  def test_board_can_render_a_sunken_ship

    board = Board.new
    submarine = Ship.new("Submarine", 2)
    board.place(submarine, ['A2', 'A3'])
    board.cells['A2'].fire_upon
    board.cells['A3'].fire_upon
    display = "  1 2 3 4 \nA . X X . \nB . . . . \nC . . . . \nD . . . . \n"
    assert_equal display, board.render
  end
end
