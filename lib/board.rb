class Board
  attr_accessor :cells

  def initialize
    @cells = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def display
    line = "-----------"
    puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
    puts line
    puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
    puts line
    puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
  end

  def reset!
    @cells = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def position(input)
    cell = input.to_i - 1
    @cells[cell]
  end

  def turn_count
    count = 0
    @cells.each do |cell|
      if cell == "X" || cell == "O"
        count += 1
      end
    end
    count
  end

  def taken?(input)
    cell = position(input)
    if cell == "X" || cell == "O"
      true
    else
      false
    end
  end

  def valid_move?(input)
    if input.to_i.between?(1,9) && taken?(input) == false
      true
    end
  end

  def update(input, player)
    if valid_move?(input) == true
      cell = input.to_i - 1
      @cells[cell] = player.token
    end
  end

  def full?
    @cells.all? do |cell|
      if cell == "X" || cell == "O"
        true
      else
        false
      end
    end
  end


end
