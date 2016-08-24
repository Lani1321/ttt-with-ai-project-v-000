module Players

  class Human < Player
    def move(board)
      puts "Player #{self.token}, please enter your move (1-9)"
      gets.chomp
    end
  end

end
