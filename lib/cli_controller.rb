class Cli

  attr_accessor :continue

  def initialize (continue = "y")
    @continue = continue
  end

#CLI start
  def self.call
    session = self.new
    puts "Let's play Tic Tac Toe!"
    until session.continue == "n" || session.continue == "N"
      session.pick_players
      session.initialize_game
      session.play_game
      session.end_game
    end
    puts "Hope to play again soon!"
  end


#helper methods
  def pick_players
    puts "Pick a number to choose a player mode:"
    puts "Enter 0 to let the computer play itself."
    puts "Enter 1 to play the computer."
    puts "Enter 2 for two players."

    input = gets.strip

    until input == "0" || input == "1" || input == "2"
      puts "Please enter 0, 1, or 2 to start your game."
      input = gets.strip
    end
  end

  def initialize_game
    players = game_setup

    case players
    when players = "0"
      game = Game.zero_player_start
    when players = "1"
      game = Game.one_player_start
    when players = "2"
      game = Game.two_player_start
    end
  end

  def play_game
    game.board.display
    game.play
  end

  def end_game
    puts "Thanks for playing! Want to play again? (type 'y' or 'n')"

    input = gets.strip

    until input == "y" || input == "n" || input == "Y" || input == "n"
      puts "Please type 'y' to play again or 'n' to exit"
      input = gets.strip
    end
    self.decision = input
  end

end
