require './lib/battleship_runner'
require './lib/board'
require './lib/cell'
require './lib/ship'
require 'pry'

class Turn

  def initialize(player_board, computer_board)
    @player_board = player_board
    @computer_board = computer_board
  end

  def display_boards
    puts @computer_board.render
    puts @player_board.render(true)
  end

  def player_select_coordinates
    puts 'Enter the coordinate for your shot.'
    loop do
      player_coordinate = gets.chomp.upcase
      if @computer_board.cells[player_coordinate] == nil
        puts 'That is an invalid coordinate, pick another'
      elsif @computer_board.cells[player_coordinate].fired_upon? == true
        puts 'You have already fired upon that coordinate, pick another'
      elsif @computer_board.valid_coordinate?(player_coordinate)
        fire_player_shot(player_coordinate)
        break
      end
    end
  end

  def computer_select_coordinates
    loop do
      computer_coordinate = @player_board.cells.keys.sample
      if @player_board.cells[computer_coordinate].fired_upon? == true
        next
      else
        fire_computer_shot(computer_coordinate)

        break
      end
    end
  end

  def fire_player_shot(player_coordinate)
    @computer_board.cells[player_coordinate].fire_upon
  end

  def fire_computer_shot(computer_coordinate)
    @player_board.cells[computer_coordinate].fire_upon
  end


  def display_turn_results
    puts @computer_board.render
    puts @player_board.render(true)
  end

  def end_game
    if player_cruiser.health + player_submarine.health == 0 || computer_cruiser.health + computer_submarine.health == 0
    end
  end
end
