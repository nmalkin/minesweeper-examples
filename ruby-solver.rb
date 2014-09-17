#! /usr/bin/env ruby
require 'net/http'
require 'uri'

HOST = "minesweeper.nm.io"

class MinesweeperSolver
  attr_accessor :board_size, :board_mine_count
  attr_reader :game_id, :game_status, :mines  

  def initialize(game_name)    
    raise "Need a Game Name" unless game_name
    @game_name = game_name
    parse_board(self.class.info)
  end

  def self.info
    uri = URI.parse("http://#{HOST}/info")
    http = Net::HTTP.new(uri.host, uri.port)
    http.request(Net::HTTP::Get.new(uri.request_uri)).body
  end

  def new_game
    raise "No game name set" unless @game_name
    uri = URI.parse("http://#{HOST}/new")
    @game_id = Net::HTTP.post_form(uri, {"name" => @game_name}).body
  end

  def parse_board(board)
    board_string = board.split(',')
    raise "Error in input: #{size_string}" if board_string.size != 3
    @board_size = { x: board_string[0].to_i, y: board_string[1].to_i}
    @board =  Array.new(@board_size[:x]) { Array.new(@board_size[:y])}
    @board_mine_count = board_string[2]
  end

  def guess(x,y)
    uri = URI.parse("http://#{HOST}/open")
    Net::HTTP.post_form(uri, {"id" => @game_id, "x" => x, "y" => y}).body    
  end

  def in_bounds(x,y)
    return false if x < 0 || y < 0
    return false if x >  @board_size[:x] - 1 || y > @board_size[:y] - 1
    return true
  end

  def neighbor_coords(x,y)
    neighbors = []
    neighbors << [x+1,y+1] if in_bounds(x+1, y+1)
    neighbors << [x+1,y] if in_bounds(x+1, y)
    neighbors << [x-1,y-1] if in_bounds(x-1, y-1)
    neighbors << [x-1,y] if in_bounds(x-1, y)
    neighbors << [x-1,y+1] if in_bounds(x-1, y+1)
    neighbors << [x,y+1] if in_bounds(x, y+1)
    neighbors << [x+1,y-1] if in_bounds(x+1, y-1)
    neighbors << [x,y-1] if in_bounds(x, y-1)
    neighbors
  end

  def print_board
    for i in 0...@board_size[:x]
      for j in 0...@board_size[:y]        
        if @board[i][j].nil?
          print " ?"
        else
          print " #{@board[i][j]}"
        end
      end
      puts
    end
  end

  def random_solve
    while true
      # Chose a random coordinate
      x = Random.rand(@board_size[:x])
      y = Random.rand(@board_size[:y])
      # Check if the coordinate was already opened
      if @board[x][y].nil?
        guess_result = guess(x,y) 
        puts "Random Guess: (#{x},#{y}): #{guess_result}"        
      end
      next if guess_result.nil?
      # If the result is not a digit it's either "win" or "lost"
      unless guess_result =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
          return guess_result
      end
      @board[x][y] = guess_result
    end
  end
end

# CHANGE HERE ------------------------------
GAMES = 1                       # Total number of games to play
GAME_NAME = "diogo@squareup.com" # XXX: Change this to your email address
solver_alg = :random_solve       # XXX: Change this to be your solver
# ------------------------------------------

results = []
 for i in 0..(GAMES-1)
  puts "# Starting new Game"
  solver = MinesweeperSolver.new(GAME_NAME)
  solver.new_game
  results << solver.send(solver_alg)
  puts "Final board:"
  puts
  solver.print_board
  puts
 end
counts = Hash.new(0)
results.each { |result| counts[result] += 1 }
puts "Final Results: #{counts["win"]} Wins, #{counts["lost"]} Losses"
