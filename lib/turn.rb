require './lib/board'
require './lib/cell'
require './lib/ship'
require 'pry'

class Turn

    attr_accessor :computer_coordinate, #for testing computer results
                  :player_coordinate    #for testing player results

  def initialize(player_board, computer_board)
    @player_board = player_board
    @computer_board = computer_board
    @player_coordinate = nil
    @computer_coordinate = nil
  end


  def begin_game
    loop do
      display_boards
      player_select_coordinates
      computer_select_coordinates
      report_player_results
      report_computer_results
    end
  end

  def display_boards
    boards = "=============COMPUTER BOARD=============\n" +
    @computer_board.render +
    "==============PLAYER BOARD==============\n" +
    @player_board.render(true)
    return boards
  end

  def player_select_coordinates
    puts 'Enter the coordinate for your shot.'
    loop do
      player_coordinate = gets.chomp.upcase
      @player_coordinate = player_coordinate
      if @computer_board.cells[player_coordinate] == nil

        # if coordinate.valid_coordinate?(coordinate)

        puts 'That is an invalid coordinate, pick another'
      elsif @computer_board.cells[player_coordinate].fired_upon? == true
        puts 'You have already fired upon that coordinate, pick another'
      elsif @computer_board.valid_coordinate?(player_coordinate)
        player_fire_shot(player_coordinate)
        break
      end
    end
  end

  def computer_select_coordinates
    loop do
      computer_coordinate = @player_board.cells.keys.sample
      @computer_coordinate = computer_coordinate
      if @player_board.cells[computer_coordinate].fired_upon? == true
        next
      else
        computer_fire_shot(computer_coordinate)

        break
      end
    end
  end

  def player_fire_shot(player_coordinate)
    @computer_board.cells[player_coordinate].fire_upon
  end

  def computer_fire_shot(computer_coordinate)
    @player_board.cells[computer_coordinate].fire_upon
  end

  def report_computer_results
    if @player_board.cells[@computer_coordinate].render == 'M'
      "My shot on #{@computer_coordinate} was a miss."
    elsif @player_board.cells[@computer_coordinate].render == 'H'
      "My shot on #{@computer_coordinate} was a hit."
    elsif @player_board.cells[@computer_coordinate].render == 'X'
      "My shot on #{@computer_coordinate} sunk your ship."
    end
  end

  def report_player_results
    if @computer_board.cells[@player_coordinate].render == 'M'
      "My shot on #{@player_coordinate} was a miss."
    elsif @computer_board.cells[@player_coordinate].render == 'H'
      "My shot on #{@player_coordinate} was a hit."
    elsif @computer_board.cells[@player_coordinate].render == 'X'
      "My shot on #{@player_coordinate} sunk your ship."
    end
  end

  # def end_game
  #   if player_cruiser.health + player_submarine.health == 0 || computer_cruiser.health + computer_submarine.health == 0
  #   end
  # end
end
