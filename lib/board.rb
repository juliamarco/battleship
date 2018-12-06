class Board
  attr_reader :cells
  def initialize
    @cells = {}
    @valid_coordinates = []

    create_cells
  end

  def create_cells
    ('A'..'D').each do |letter|
      ('1'..'4').each do |number|
        coordinate = "#{letter}#{number}"
        @cells[coordinate] = Cell.new(coordinate)
      end
    end
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end


    #  def valid_coordinate?(coordinate)
    # ('A'..'D').map do |letter|
    #   ('1'..'4').map do |number|
    #     each_coordinate = "#{letter}#{number}"
    #     @valid_coordinates << each_coordinate
    #   end
    # end
    # p @valid_coordinates
  #   # @valid_coordinates.include?(coordinate)
  # end

  def valid_placement?(ship, coordinates)
    if ship.length != coordinates.length
      false
    elsif valid_coordinate?(coordinates)
    elsif coordinates.any? do |coordinate|
      @cells[coordinate].ship != nil
    end
      false
    else
      letter_ordinates = []
      number_ordinates = []
      coordinate_pairs = []
      coordinates.each_cons(2).each do |pair|
        coordinate_pairs << pair
      end
      coordinate_pairs.flatten.each do |coordinate|
        letter_ordinates << coordinate[0].ord
        number_ordinates << coordinate[1].ord
      end
      if letter_ordinates.uniq.length > 1 && number_ordinates.uniq.length > 1
         return false
      end
      coordinate_pairs.all? do |pair|
        vertical_shift = pair[1][0].ord - pair[0][0].ord
        horizontal_shift = pair[1][1].ord - pair[0][1].ord
        vertical_shift + horizontal_shift == 1
      end
    end
  end

  def place(ship, coordinates)
    coordinates.each do |coordinate|
      @cells[coordinate].ship = ship
    end
  end

  def render(show_ships = false)
    cell_display = []
    empty_display = ["  1 2 3 4 \nA ", "\nB ", "\nC ", "\nD ", "\n"]
    @cells.values.each do |cell|
      if show_ships == true
        cell_display << cell.render(true)
      else
        cell_display << cell.render
      end
    end
    cell_display = cell_display.each_slice(4).to_a
    empty_display.zip(cell_display).flatten.compact.join(" ")
  end



end
