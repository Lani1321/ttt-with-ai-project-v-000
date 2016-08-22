module Players
  class Computer < Player

    def move(board)
      count = board.turn_count
  		case count
      when 0 || 1
        first_move(board)
      when 2 || 3
        second_move(board)
      when count > 3
        finish_moves(board)
      end
    end

    def first_move(board)
      if !board.taken?("5")
        input = "5"
      else board.turn_count == 1
        input = ["1", "3", "7", "9"].sample
      end
    end

    def second_move(board)
      if game.player_1 == self && board.turn_count == 2
        input = ["1", "3", "7", "9"].sample
        if board.valid_move?(input)
          input
        else
          moves = ["1", "3", "7", "9"].reject(input)
          input = moves.sample
        end

      elsif game.player_2 == self && turn_count == 3
        if !win_check(board).nil?
          win_space = win_check(board)
          input = (win_space + 1).to_s
        elsif !block_check(board).nil?
          block_space = block_check(board)
          input = (block_space + 1).to_s
        else
          valid = board.cells.detect {|cell| !cell.taken?}
          input = (valid + 1).to_s
        end
      end
    end

    def finish_moves(board)
      if !win_check(board).nil?
        win_space = win_check(board)
        input = (win_space + 1).to_s
      elsif !block_check(board).nil?
        block_space = block_check(board)
        input = (block_space + 1).to_s
      else
        valid = board.cells.detect {|cell| !cell.taken?}
        input = (valid + 1).to_s
      end
    end

    def block_check(board)
      enemy_token = nil
      if self.token == "X"
        enemy_token = "O"
      else
        enemy_token = "X"
      end

      block_opportunity = []
      block_opportunity << Game.WIN_COMBINATIONS.detect do |combo|
        (enemy_token == board.cells[combo[0]] && board.cells[combo[0]] == board.cells[combo[1]] && !board.cells[combo[2]].taken?) || (!board.cells[combo[0]].taken? && board.cells[combo[1]] == board.cells[combo[2]] && board.cells[combo[1]] == enemy_token) || (!board.cells[combo[1]].taken? && board.cells[combo[0]] == enemy_tokenn && board.cells[combo[0]] == board.cells[combo[2]])
      end

      if block_opportunity.size == 1
        block_space = block_opportunity.detect {|cell| !cell.taken?}
      elsif block_opportunity.size > 1
        block_space = block_opportunity.first.detect {|cell| !cell.taken?}
      else
        nil
      end
    end

    def win_check(board)
      win_opportunity = []
      win_opportunity << Game.WIN_COMBINATIONS.detect do |combo|
        (self.token == board.cells[combo[0]] && board.cells[combo[0]] == board.cells[combo[1]] && !board.cells[combo[2]].taken?) || (!board.cells[combo[0]].taken? && board.cells[combo[1]] == board.cells[combo[2]] && board.cells[combo[1]] == self.token) || (!board.cells[combo[1]].taken? && board.cells[combo[0]] == self.token && board.cells[combo[0]] == board.cells[combo[2]])
      end
      if win_opportunity.size == 1
        win_space = win_opportunity.detect {|cell| !cell.taken?}
      elsif block_opportunity.size > 1
        win_space = win_opportunity.first.detect {|cell| !cell.taken?}
      else
        nil
      end
    end
  end
end
