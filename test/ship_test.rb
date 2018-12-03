require 'minitest/autorun'
require './lib/ship'

class ShipTest < Minitest::Test
  def test_it_exists
    cruiser = Ship.new('Cruiser', 3)
    assert_instance_of Ship, cruiser
  end

  def test_it_has_a_name
    cruiser = Ship.new('Cruiser', 3)
    assert_equal 'Cruiser', cruiser.name
  end

  def test_it_has_a_length
    cruiser = Ship.new('Cruiser', 3)
    assert_equal 3, cruiser.length
  end

  def test_it_has_health
    cruiser = Ship.new('Cruiser', 3)
    assert_equal 3, cruiser.health
  end

  def test_it_is_not_sunk
    cruiser = Ship.new('Cruiser', 3)
    assert_equal false, cruiser.sunk?
  end

  def test_it_can_be_hit
    cruiser = Ship.new('Cruiser', 3)
    cruiser.hit
    assert equal 2, cruiser.health
  end

  def test_it_can_sink
    cruiser = Ship.new('Cruiser', 3)
    cruiser.hit
    cruiser.hit
    cruiser.hit
    assert_equal true, cruiser.sunk?
  end
end
