require './lib/cell'
require './lib/ship'

class Board
  attr_reader :cells

  def initialize(number = 4)
    @cells = {}
    @letter = (64 + number).chr
    @number = number
    create_cells(@letter, @number)
  end

  def create_cells(letter, number)
    ('A'..letter.to_s).each do |each_letter|
      ('1'..number.to_s).each do |each_number|
        coordinate = "#{each_letter}#{each_number}"
        @cells[coordinate] = Cell.new(coordinate)
      end
    end
  end

  def valid_coordinates?(coordinates)
    #sometimes you need to check the coordinates as a pair(when selecting when to place a ship)
    coordinates.all? do |coordinate|
      @cells.key?(coordinate)
    end
  end

  def valid_coordinate?(coordinate)
    #sometimes you need to check a single coordinate(to fire upon a cell)
    @cells.key?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    all_values = []
    all_values << number_of_ordinates_equals_length(ship, coordinates)
    all_values << valid_coordinates?(coordinates)
    all_values << ships_cannot_overlap(coordinates)
    all_values << compare_ordinates(coordinates)
    all_values << coordinates_are_consecutive(coordinates)
    if all_values.include?(false)
      return false
    else
      return true
    end
  end

  def number_of_ordinates_equals_length(ship, coordinates)
    ship.length == coordinates.length
  end

  def ships_cannot_overlap(coordinates)
    coordinates.all? do |coordinate|
      if @cells.key?(coordinate)
        @cells[coordinate].empty?
      end
    end
  end

  def all_letter_ordinates(coordinates)
    #in order to compare ordinates
    coordinates.map do |coordinate|
      coordinate[0].ord
    end
  end

  def all_number_ordinates(coordinates)
    #in order to compare ordinates
    coordinates.map do |coordinate|
      coordinate[1].ord
    end
  end

  def compare_ordinates(coordinates)
    #to make sure something like [a1, a1] would not work
    if all_letter_ordinates(coordinates).uniq.length > 1 && all_number_ordinates(coordinates).uniq.length > 1
      false
    else
      true
    end
  end

  def all_coordinate_pairs(coordinates)
    #to check later on that they are consecutive
    coordinates.each_cons(2).map do |pair|
      pair
    end
  end

  def coordinates_are_consecutive(coordinates)
    all_coordinate_pairs(coordinates).all? do |pair|
      letter_shift = all_letter_ordinates(pair)[1] - all_letter_ordinates(pair)[0]
      number_shift = all_number_ordinates(pair)[1] - all_number_ordinates(pair)[0]
      letter_shift + number_shift == 1
    end
  end

  def place(ship, coordinates)
    coordinates.each do |coordinate|
      @cells[coordinate].ship = ship
    end
  end

  def render(show_ships = false)
    cell_display = []
    numbers_array = (1..@number).to_a
    letters_array = ('A'..(64 + @number).chr).to_a
    letters_array = letters_array.map do |letter|
      "\n#{letter}"
    end
    letters_array << "\n"
    numbers_array = '  ' + numbers_array.join(' ') + ' '
    numbers_letters_joined = numbers_array + letters_array[0]
    letters_array.delete_at(0)
    empty_display = letters_array.unshift(numbers_letters_joined)
    #creates  ["  1 2 3 4 \nA", "\nB", "\nC", "\nD", "\n"]
    @cells.values.each do |cell|
      if show_ships == true
        cell_display << cell.render(true)
      else
        cell_display << cell.render
      end
    end
    cell_display = cell_display.each_slice(@number).to_a
    #creates [".", ".", ".", "."] sliced by board number
    empty_display.zip(cell_display).flatten.compact.join(' ')
  end
end
