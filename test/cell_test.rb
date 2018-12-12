require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test
  def test_it_exists
    cell = Cell.new('B4')
    assert_instance_of Cell, cell
  end

  def test_the_coordinates
    cell = Cell.new('B4')
    assert_equal 'B4', cell.coordinate
  end

  def test_it_contains_a_ship
    cell = Cell.new('B4')
    assert_equal nil, cell.ship
  end

  def test_cell_is_empty
    cell = Cell.new('B4')
    assert_equal true, cell.empty?
  end

  def test_we_can_place_a_ship
    cell = Cell.new('B4')
    cruiser = Ship.new('Cruiser', 3)
    cell.place_ship(cruiser)
    assert_equal cruiser, cell.ship
  end

  def test_cell_is_not_empty_anymore
    cell = Cell.new('B4')
    cruiser = Ship.new('Cruiser', 3)
    cell.place_ship(cruiser)
    assert_equal false, cell.empty?
  end

  def test_cell_starts_not_fired_upon
    cell = Cell.new('B4')
    cruiser = Ship.new('Cruiser', 3)
    cell.place_ship(cruiser)
    assert_equal false, cell.fired_upon?
  end

  def test_cell_can_be_fired_upon
    cell = Cell.new('B4')
    cruiser = Ship.new('Cruiser', 3)
    cell.place_ship(cruiser)
    cell.fire_upon
    assert_equal true, cell.fired_upon?
  end

  def test_ship_is_hit_when_cell_fired_upon
    cell = Cell.new('B4')
    cruiser = Ship.new('Cruiser', 3)
    cell.place_ship(cruiser)
    cell.fire_upon
    assert_equal 2, cell.ship.health
  end

  def test_new_cell_render
    cell = Cell.new('B4')
    assert_equal '.', cell.render
  end

  def test_cell_renders_m_if_missed
    cell = Cell.new('B4')
    cell.fire_upon
    assert_equal 'M', cell.render
  end

  def test_cell_render_s_if_true
    cell = Cell.new('B4')
    cruiser = Ship.new('Cruiser', 3)
    cell.place_ship(cruiser)
    assert_equal 'S', cell.render(true)
  end

  def test_cell_renders_h_if_hit
    cell = Cell.new('B4')
    cruiser = Ship.new('Cruiser', 3)
    cell.place_ship(cruiser)
    cell.fire_upon
    assert_equal 'H', cell.render
  end

  def test_cell_renders_x_if_ship_sunk
    cell_1 = Cell.new('B4')
    cell_2 = Cell.new('B3')
    cruiser = Ship.new('Cruiser', 2)
    cell_1.place_ship(cruiser)
    cell_2.place_ship(cruiser)
    cell_1.fire_upon
    cell_2.fire_upon
    assert_equal 'X', cell_1.render
    assert_equal 'X', cell_2.render
  end
end
