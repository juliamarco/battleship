class Cell
  attr_reader   :coordinate

  attr_accessor :ship,
                :fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship.nil?
  end

  def place_ship(ship)
    @ship = ship
  end

  def fire_upon
    if @ship
      @ship.hit
    end
    @fired_upon = true
  end

  def fired_upon?
    @fired_upon
  end

  def render(player_ship = false)
    if player_ship == true && @fired_upon == false && @ship.nil? == false
      'S'
    elsif @fired_upon == false
      '.'
    elsif @ship.nil?
      'M'
    elsif @ship.sunk? == false
      'H'
    else
      'X'
    end
  end
end
