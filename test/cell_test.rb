require 'minitest/autorun'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test

  def test_it_exists

    cell = Cell.new("B4")

  assert_instance_of Cell, cell
  end

  def test_the_coordinates

    cell = Cell.new("B4")

  assert_equal "B4", cell.coordinate
  end

  def test_it_contains_a_ship

    cell = Cell.new("B4")

  assert_equal nil, cell.ship
  end

  def test_cell_is_empty

    cell = Cell.new("B4")

  assert_equal true, cell.empty?
  end

  def test_we_can_place_a_ship

    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

  assert_equal cruiser, cell.ship
  end

  def test_cell_is_not_empty_anymore

    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

  assert_equal false, cell.empty?
  end







end
