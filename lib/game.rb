class Game

  attr_accessor :board, :player_1, :player_2, :winning_combo

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [2,4,6],
    [0,4,8]
  ]

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

#game management methods

  def play
    until self.over?
      self.turn
    end
    if self.won?
      puts "Congratulations #{winner}!"
    else
      puts "Cats Game!"
    end
  end

  def turn
    input = current_player.move(board)
    if @board.valid_move?(input)
      board.update(input, current_player)
    else
      puts "invalid"
      self.turn
    end
  end

#game status methods

  def current_player
    @board.turn_count.even? ? @player_1 : @player_2
  end

  def over?
    draw? || won?
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

end
