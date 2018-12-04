require './lib/cell'


class Board

  attr_reader :cells

  def initialize
    @cells = {}
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
    valid_coordinates = []
    ("A".."D").map do |letter|
      ("1".."4").map do |number|
        each_coordinate = "#{letter}#{number}"
        valid_coordinates << each_coordinate
      end
    end
    valid_coordinates.include?(coordinate)

  end


end
  
