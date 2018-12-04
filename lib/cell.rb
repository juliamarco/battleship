class Cell
  attr_reader :coordinate,
              :ship
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil

  end

  def empty?
    @ship.nil?
  end

  def place_ship(ship)
    @ship = ship
  end

  def fire_upon
    @ship.hit
  end

  def fired_upon?
    @ship.health < @ship.length
  end

  # def render
  #   if @ship.sunk?
  #     "X"
  #   elsif fired_upon?
  #     "H"
  #   elsif fired_upon?
  #   else
  #     "."
  #   end
  # end
  end




end
