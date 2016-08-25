class Game
  attr_accessor :board, :player_1, :player_2
   WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
  ]

#setup methods

 def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

  def self.zero_player_start
    self.new(player_1 = Players::Computer.new("X"), player_2 = Players::Computer.new("O"))
  end

  def self.one_player_start
    puts "Who should go first? Please enter '1' for the human player or '2' for the computer"
    first_player = gets.strip
    if first_player == "1"
      puts "You are Player X!"
      self.new(player_1 = Players::Human.new("X"), player_2 = Players::Computer.new("O"))
    elsif first_player == "2"
      puts "You are Player 0!"
      self.new(player_1 = Players::Computer.new("X"), player_2 = Players::Human.new("O"))
    end
  end

  def self.two_player_start
    puts "Player 1 is X and Player 2 is O"
    self.new
  end

#game status methods

  def current_player
    @board.turn_count.even? ? @player_1 : @player_2
  end

  def won?
    @winning_combo = WIN_COMBINATIONS.detect do |combo|
      @board.taken?(combo[0] + 1) && @board.cells[combo[0]] == @board.cells[combo[1]] && @board.cells[combo[1]] == @board.cells[combo[2]]
    end
    @winning_combo.nil? ? false : true
  end

  def winner
    won? ? @board.cells[@winning_combo[0]] : nil
  end

  def draw?
    @board.full? && !won?
  end

  def over?
    won? || draw?
  end

#game management methods

  def play
    until over?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cats Game!"
    end
  end

  def turn
    current = current_player
    current_move = current_player.move(@board)
    if @board.valid_move?(current_move)
      @board.update(current_move, current_player)
      @board.display
      puts ""
      puts "Player #{current.token} made a move."
      puts ""
    else
      puts "Invalid move."
      turn
    end


  end

end
