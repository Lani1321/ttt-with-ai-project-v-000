module Players
  class Computer < Player

    def determine_opponent
      if self.token == "X"
        opponent_token = "O"
      else
        opponent_token = "X"
      end
      opponent_token
    end

    def move(board)
      if board.turn_count == 0 || board.turn_count == 1
        first_move(board)
      elsif board.turn_count == 2 || board.turn_count == 0
        second_move(board)
      else
        finish_moves(board)
      end
    end

    def first_move(board)
      if !board.taken?("5")
        input = "5"
      else
        input = ["1", "3", "7", "9"].sample
      end
      input
    end

    def second_move(board)
      if self.token == "X"
        input = ["1", "3", "7", "9"].sample
        until board.valid_move?(input)
        input = ["1", "3", "7", "9"].sample
        end
        input
      elsif self.token == "O"
        finish_moves(board)
      end
    end

    def finish_moves(board)
      if win_space(board) != nil
        win_space(board)
      elsif block_space(board) != nil
        block_space(board)
      else
        input = ["1", "2", "3", "4", "5", "6", "7", "8", "9"].detect {|cell| !board.taken?(cell)}
      end
    end

    def win_check(board, token_to_check)
      token = token_to_check
      win_opportunity = []
      win_opportunity << Game::WIN_COMBINATIONS.detect do |combo|
        (token == board.cells[combo[0]] && board.cells[combo[0]] == board.cells[combo[1]] && !board.taken?("#{combo[2] + 1}")) || (token == board.cells[combo[1]] && board.cells[combo[1]] == board.cells[combo[2]] && !board.taken?("#{combo[0] + 1}")) || (token == board.cells[combo[0]]  && board.cells[combo[0]] == board.cells[combo[2]] && !board.taken?("#{combo[1] + 1}"))
      end
      win_opportunity.flatten
    end

    def win_space(board)
      if win_check(board, self.token) != [nil]
        win = win_check(board, self.token)
        cell = win.detect {|cell| !board.taken?("#{cell + 1}")}
        input = "#{cell + 1}"
      else
        nil
      end
    end

    def block_space(board)
      opponent_token = self.determine_opponent
      if win_check(board, token_to_check = opponent_token) != [nil]
        block = win_check(board, token_to_check = opponent_token)
        cell = block.detect {|cell| !board.taken?("#{cell + 1}")}
        input = "#{cell + 1}"
      else
        nil
      end
    end
  end
end
