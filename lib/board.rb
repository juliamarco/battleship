require 'pry'
require './lib/cell'
require './lib/ship'


class Board
  attr_reader :cells
  def initialize
    @cells = {}


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

  def valid_coordinates?(coordinates)
    coordinates.all? do |coordinate|
      @cells.keys.include?(coordinate)
    end
  end

  def valid_coordinate?(coordinate)
      @cells.keys.include?(coordinate)
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
        if @cells.has_key?(coordinate)
          @cells[coordinate].empty?
        end
      end
  end

  def all_coordinate_pairs(coordinates)
      coordinate_pairs = coordinates.each_cons(2).map do |pair|
        pair
      end
  end

  def all_letter_ordinates(coordinates)
      letter_ordinates = all_coordinate_pairs(coordinates).flatten.map do |coordinate|
      coordinate[0].ord
      end
  end

  def all_number_ordinates(coordinates)
      number_ordinates = all_coordinate_pairs(coordinates).flatten.map do |coordinate|
      coordinate[1].ord
      end
  end

  def compare_ordinates(coordinates)
    if all_letter_ordinates(coordinates).uniq.length > 1 && all_number_ordinates(coordinates).uniq.length > 1
      return false
    else
      return true
    end
  end

  def coordinates_are_consecutive(coordinates)
    all_coordinate_pairs(coordinates).all? do |pair|
      letter_shift = all_letter_ordinates(pair)[1] - all_letter_ordinates(pair)[0]
      number_shift =all_number_ordinates(pair)[1] - all_number_ordinates(pair)[0]
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
