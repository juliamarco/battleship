require './lib/cell'
require './lib/ship'
require 'pry'


class Board

  attr_reader :cells

  def initialize
    @cells = {}
    @valid_coordinates = []

    create_cells
  end

  def create_cells
    ("A".."D").each do |letter|
      ("1".."4").each do |number|
        coordinate = "#{letter}#{number}"
        @cells[coordinate] = Cell.new(coordinate)
      end
    end
  end


  def valid_coordinate?(coordinate)
    ("A".."D").map do |letter|
      ("1".."4").map do |number|
        each_coordinate = "#{letter}#{number}"
        @valid_coordinates << each_coordinate
      end
    end
    @valid_coordinates.include?(coordinate)

  end

  def valid_placement?(ship, coordinates)
    if ship.length != coordinates.length
      false
    elsif valid_coordinate?(coordinates)
    else
      coordinate_pairs = []
      coordinates.each_cons(2).each do |pair|
        coordinate_pairs << pair
      end
        coordinate_pairs.all? do |pair|
          letter_shift = pair[1][0].ord - pair[0][0].ord
          number_shift = pair[1][1].ord - pair[0][1].ord
          letter_shift + number_shift == 1
          end
        end
      end
    end
