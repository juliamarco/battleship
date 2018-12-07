class Turn
  attr_reader :player_shot,
              :computer_shot
  def initialize(player_shot, computer_shot)
    @player_shot = player_shot
    @computer_shot = computer_shot
  end

  def fire_shots
    player_board.cells[@computer_shot].fire_upon
    computer_board.cells[@player_shot].fire_upon
  end

  def turn_results
    computer_shot = player_board.cells[@computer_shot].render
    player_shot = computer_board.cells[@player_shot].render
    if computer_shot == "M"
      puts "The computer's shot on #{@computer_shot} missed."
    elsif computer_shot == "H"
      puts "The computer's shot on #{@computer_shot} was a hit."
    elsif computer_shot == "X"
      puts "The computer's shot on #{@computer_shot} sunk your ship."
    end
  end
  

end
