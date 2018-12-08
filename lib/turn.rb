require './lib/battleship_runner'
require './lib/board'
require './lib/cell'
require './lib/ship'
require 'pry'

class Turn

  def initialize(player_board, computer_board)
    @player_board = player_board
    @computer_board = computer_board
    @player_shot = nil
    @computer_shot = nil
  end

  def display_boards
    puts @computer_board.render
    puts @player_board.render(true)
  end

  def player_select_coordinates
    puts 'Enter the coordinate for your shot.'
    loop do
      puts @computer_board.render
      player_shot = gets.chomp
      if @computer_board.cells[player_shot] == nil
        puts 'That is an invalid coordinate, pick another'
        next
      elsif @computer_board.cells[player_shot].fired_upon? == true
        puts 'You have already fired upon that coordinate, pick another'
      elsif @computer_board.valid_coordinate?(player_shot)
        @computer_board.cells[player_shot].fire_upon
        break
      end
    end
  end

  def computer_select_coordinates
    loop do
      computer_shot = @player_board.cells.keys.sample
      if @player_board.cells[computer_shot].fired_upon? == true
        next
      else
        @player_board.cells[computer_shot].fire_upon
        puts @player_board.render(true)
        break
      end
    end
  end

  def fire_shots
    @player_board.cells[@computer_shot].fire_upon
    @computer_board.cells[@player_shot].fire_upon
  end

  def display_player_turn_results
    computer_shot_result = @player_board.cells[@computer_shot].render
    player_shot_result = @computer_board.cells[@player_shot].render
    if computer_shot == 'M'
      puts "The computer's shot on #{@computer_shot} missed."
    elsif computer_shot == 'H'
      puts "The computer's shot on #{@computer_shot} was a hit."
    elsif computer_shot == 'X'
      puts "The computer's shot on #{@computer_shot} sunk your ship."
    end
  end

  def end_game
    if player_cruiser.health + player_submarine.health == 0 || computer_cruiser.health + computer_submarine.health == 0
    end
  end
end
