require './lib/board'
require './lib/cell'
require './lib/ship'
require 'pry'

class GameSetup
  attr_accessor :turn,
                :board_size

  def initialize(turn)
    @turn = turn
    @board_size = nil
    @ship_name = 0
    @player_ships = []
    @ship_length = 0
  end

  def main_menu
    loop do
      puts 'Welcome to BATTLESHIP'
      puts 'Enter p to play. Enter q to quit.'
      input = gets.chomp.upcase
      if input == 'Q'
        return
      elsif input == 'P'
        system('clear')
        custom_board_size
        setup
        @turn.begin_turn
      else
        system('clear')
        next
      end
    end
  end

  def custom_board_size
    loop do
      puts 'Enter the size of the board from 4 to 10 (e.g. 4 creates a 4 x 4 board).'
      board_size = gets.chomp.to_i
      @board_size = board_size
      if board_size < 4
        system('clear')
        puts 'That board size is too small. Try again.'
        next
      elsif board_size > 10
        system('clear')
        puts 'That board size is too large. Try again.'
        next
      else
        player_board = Board.new(board_size)
        computer_board = Board.new(board_size)
        @turn = Turn.new(player_board, computer_board)
        system('clear')
        break
      end
    end
  end

  def setup
    player_setup
    computer_setup
  end

  def player_setup
    loop do
      player_creates_ship
      player_places_ship
      if ask_player_if_they_want_to_create_another_ship == false
        return
      end
    end
  end

  def player_creates_ship
    puts 'Enter a ship name'
    ship_name = gets.chomp
    system('clear')
    @ship_name = ship_name
    loop do
      puts "Enter a ship length from 2 to #{@board_size}"
      ship_length = gets.chomp.to_i
      if ship_length < 2 || ship_length > @board_size
        system('clear')
        puts 'That length is invalid, try again'
      else
        @ship_length = ship_length
        system('clear')
        break
      end
    end
  end

  def player_places_ship
    loop do
      puts "=============PLAYER BOARD=============\n" + @turn.player_board.render(true)
      puts "Enter the #{@ship_length} squares for the #{@ship_name} separated by spaces (e.g. A1 A2 A3)"
      player_ship = Ship.new(@ship_name, @ship_length)
      @player_ships << player_ship
      player_ship_coordinates = gets.chomp.upcase.split
      if player_ship_coordinates.any? {|coordinate| coordinate.length != 2}
        system('clear')
        puts 'Those coordinates are invalid'
      elsif @turn.player_board.valid_placement?(player_ship, player_ship_coordinates)
        @turn.player_board.place(player_ship, player_ship_coordinates)
        system('clear')
        puts  "=============PLAYER BOARD=============\n" + @turn.player_board.render(true)
        break
      else
        system('clear')
        puts 'Those coordinates are invalid'
      end
    end
  end

  def ask_player_if_they_want_to_create_another_ship
    loop do
      puts 'Would you like to create another ship? y/n'
      answer = gets.chomp.upcase
      if answer == 'Y'
        system('clear')
        break
      elsif answer == 'N'
        system('clear')
        return false
      else
        system('clear')
        puts "=============PLAYER BOARD=============\n" + @turn.player_board.render(true)
        next
      end
    end
  end

  def computer_setup
    while @player_ships.count.positive?
      computer_create_possible_placements
      @player_ships.shift
    end
  end

  def computer_create_possible_coordinates
    letter = (64 + @board_size).chr
    number = @board_size
    ('A'..letter.to_s).map do |each_letter|
      ('1'..number.to_s).map do |each_number|
        "#{each_letter}#{each_number}"
      end
    end
  end

  def computer_create_possible_placements
    loop do
      possible_horizontal_placements = computer_create_possible_coordinates.flatten.each_cons(@player_ships[0].length).map do |coordinates|
      coordinates
      end
      sorted_coordinates = computer_create_possible_coordinates
      array = []
      until sorted_coordinates[-1].empty?
        sorted_coordinates.each do |coordinate|
          array << coordinate[0]
          coordinate.shift
        end
      end
      possible_vertical_placements = array.each_cons(@player_ships[0].length).map do |coordinates|
        coordinates
      end
      all_possible_placements = (possible_horizontal_placements + possible_vertical_placements)
      ship = Ship.new(@player_ships[0].name, @player_ships[0].length)
      random_placement = all_possible_placements.sample
      if @turn.computer_board.valid_placement?(ship, random_placement)
        @turn.computer_board.place(ship, random_placement)
        break
      end
    end
  end
end
