require './lib/board'
require './lib/cell'
require './lib/ship'
require 'pry'

class Turn

    attr_accessor :computer_coordinate,
                  :player_coordinate
    attr_reader :player_board,
                :computer_board

  def initialize(player_board, computer_board)
    @player_board = player_board
    @computer_board = computer_board
    @player_coordinate = nil
    @computer_coordinate = nil
  end


  def begin_turn
    loop do
      puts display_boards
      player_select_coordinates
      computer_select_coordinates
        system("clear")
      p report_player_results
      p report_computer_results
      if player_wins_game
        puts "You win!"
        break
      elsif computer_wins_game
        puts "You lose."
        break
      else next
      end
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

        if @computer_board.valid_coordinate?(player_coordinate) == false

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
      "Your shot on #{@player_coordinate} was a miss."
    elsif @computer_board.cells[@player_coordinate].render == 'H'
      "Your shot on #{@player_coordinate} was a hit."
    elsif @computer_board.cells[@player_coordinate].render == 'X'
      "Your shot on #{@player_coordinate} sunk my ship."
    end
  end

  def player_wins_game
    cells_with_ship = @computer_board.cells.values.map do |cell|
      if cell.empty?
      else cell.ship.health
      end
    end
    cells_with_ship.compact!.all? do |health|
      health == 0
    end
  end

  def computer_wins_game
    cells_with_ship = @player_board.cells.values.map do |cell|
      if cell.empty?
      else cell.ship.health
      end
    end
    cells_with_ship.compact!.all? do |health|
      health == 0
    end
  end
end
