require './lib/board'
require './lib/cell'
require './lib/ship'
require 'pry'

class GameSetup
    attr_accessor :turn

  def initialize(turn)
    @turn = turn
  end

  def main_menu
    loop do
      puts "Welcome to BATTLESHIP"
      puts "Enter p to play. Enter q to quit."
        input = gets.chomp.upcase
          if input  == "Q"
            return
          elsif input == "P"
            custom_board_size
            setup
            @turn.begin_game
          else
            next
          end
    end
  end

  def custom_board_size
    loop do
      puts "Enter the size of the board from 4 to 10 (e.g. 4 creates a 4 x 4 board)."
      board_size = gets.chomp.to_i
      if board_size < 4
        puts "That board size is too small. Try again."
        next
      elsif board_size > 10
        puts "That board size is too large. Try again."
        next
      else
        player_board = Board.new(board_size)
        computer_board = Board.new(board_size)
        @turn = Turn.new(player_board, computer_board)
        break
      end
    end
  end


  def setup
    computer_setup
    player_setup
  end

  def player_setup
    player_cruiser = Ship.new('cruiser', 3)
    player_submarine = Ship.new('submarine', 2)
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts "=============PLAYER BOARD=============\n" + @turn.player_board.render

    loop do
      puts "Enter the three squares for the Cruiser separated by spaces (e.g. A1 A2 A3)"
      player_cruiser_coordinates = gets.chomp.upcase.split
      if @turn.player_board.valid_placement?(player_cruiser, player_cruiser_coordinates)
        @turn.player_board.place(player_cruiser, player_cruiser_coordinates)
        break
      else
        puts "Those coordinates are invalid"
      end
    end
    puts  "=============PLAYER BOARD=============\n" + @turn.player_board.render(true)
    loop do
      puts "Enter the two squares for the Submarine separated by spaces (e.g. A1 A2)"
      player_submarine_coordinates = gets.chomp.upcase.split
      if @turn.player_board.valid_placement?(player_submarine, player_submarine_coordinates)
        @turn.player_board.place(player_submarine, player_submarine_coordinates)
      break
      else
      puts "Those coordinates are invalid"
      end
    end
  end

  def computer_setup
    computer_cruiser = Ship.new('cruiser', 3)
    computer_submarine = Ship.new('submarine', 2)
    valid_cruiser_placement = [['A1', 'A2', 'A3'], ['A2', 'A3', 'A4'], ['B1', 'B2', 'B3'], ['B2', 'B3', 'B4'], ['C1', 'C2', 'C3'], ['C2', 'C3', 'C4'], ['D1', 'D2', 'D3'], ['D2', 'D3', 'D4'], ['A1', 'B1', 'C1'], ['C1', 'B1', 'D1'], ['A2', 'B2', 'C2'], ['B2', 'C2', 'D2'], ['A3', 'B3', 'C3'], ['B3', 'C3', 'D3'], ['A4', 'B4', 'C4'], ['B4', 'C4', 'D4']]
    random_cruiser_coordinate = valid_cruiser_placement.sample
    @turn.computer_board.place(computer_cruiser, random_cruiser_coordinate)
    @turn.computer_board.render(false)
    valid_submarine_placement = [['A1', 'A2'], ['A2', 'A3'], ['A3', 'A4'], ['B1', 'B2'], ['B2', 'B3'], ['B3', 'B4'], ['C1', 'C2'], ['C2', 'C3'], ['C3', 'C4'], ['D1', 'D2'], ['D2', 'D3'], ['D3', 'D4'], ['A1', 'B1'], ['B1', 'C1'], ['C1', 'D1'], ['A2', 'B2'], ['B2', 'C2'], ['C2', 'D2'], ['A3', 'B3'], ['B3', 'C3'], ['C3', 'D3'], ['A4', 'B4'], ['B4', 'C4'], ['C4', 'D4']]
    loop do
      random_submarine_coordinate = valid_submarine_placement.sample
      if @turn.computer_board.valid_placement?(computer_submarine, random_submarine_coordinate)
        @turn.computer_board.place(computer_submarine, random_submarine_coordinate)
        break
      end
    end
  end

 end
