require 'pry'
class TicTacToe

  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  WIN_COMBINATIONS = [
    [0,1,2], [3,4,5], [6,7,8],
    [0,3,6], [1,4,7], [2,5,8],
    [0,4,8], [6,4,2]
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} \n
          ----------- \n
           #{@board[3]} | #{@board[4]} | #{@board[5]} \n
          ----------- \n
           #{@board[6]} | #{@board[7]} | #{@board[8]} \n"
  end

  def input_to_index(input)
    index = input.to_i - 1
  end

  def move(index, token = "X")
    @board[index] = token
  end

  def position_taken?(index)
    @board[index] == "X" || @board[index] == "O"
  end

  def valid_move?(index)
    index.between?(0,8) && position_taken?(index) == false
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      current_player == "O" ? move(index, "O") : move(index, "X")
      display_board
    else
      turn
    end
  end

  def turn_count
    @board.select{|space| space != " "}.length
  end

  def current_player
    turn_count.odd? ? "O" : "X"
  end

  def won?
    WIN_COMBINATIONS.detect do |combo|
      @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]] && position_taken?(combo[0])
    end
  end

  def full?
    @board.all?{|space| space == "X" || space == "O"}
  end

  def draw?
    full? && !won?
  end

  def over?
    draw? || won?
  end

  def winner
    if won? && @board.select{|i| i == "X"}.length > @board.select{|i| i == "O"}.length
      "X"
    elsif won? && @board.select{|i| i = "O"}.length > @board.select{|i| i == "X"}.length
      "O"
    end
  end

  def play
    until over?
      turn
      draw?
    end
    puts "Congratulations #{winner}!" if won?
    puts "Cat's Game!" if draw?
  end

end
