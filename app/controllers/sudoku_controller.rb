
#
# the sudoku controller, uly, july2012
# 
# provides a way to run our sudoku.jar;
# ie. solve a puzzle, get a new puzzle, etc.
#
class SudokuController < ApplicationController

  respond_to :html, :json 

  #
  # solve a puzzle,
  # to be called from the view via ajax;
  # expects the "puzzle" url parameter.
  #
  # example:
  # http://localhost:3000/sudoku/solve?puzzle=1234
  #
  def solve
    logger.debug "..solve.., params:#{ params }";

    #
    # the puzzle input we want to solve.
    # ie 800000000003600000070090200050007000000045700000100030001000068008500010090000400
    #
    puzzle = params[ :puzzle ];
#   puzzle = "800000000003600000070090200050007000000045700000100030001000068008500010090000400";
    logger.debug "puzzle:#{puzzle}";
   
    solution = get_solution_to_puzzle( puzzle );
    logger.debug "solution:#{solution}";

    respond_with( solution.to_json() );
  end

  #
  # query the server for the next puzzle;
  # defaults to the "next" puzzle if no id is given.
  #
  def puzzle 
    logger.debug "..puzzle..";
  end

  #---------------------------------------------------------------------------
  #
  # "private" methods
  # kept public to simplify testing purposes.
  #
  #---------------------------------------------------------------------------

  #
  # execute our jar.
  #
  # reference:
  # http://www.ruby-forum.com/topic/206880
  # http://stackoverflow.com/questions/690151/getting-output-of-system-calls-in-ruby
  #
  def get_solution_to_puzzle( puzzle ) 
    jar_answer = exec_sudoku_jar( puzzle ); 
    answer = jar_answer[1..-2];         #..drop brackets..  
    answer = answer.split().join( '' ); 
    return answer;
  end

  #
  # magically run our java command from rails.
  #
  # example:
  # java -jar cosmosgame-sudoku-0.1.0-SNAPSHOT-standalone.jar 800000000003600000070090200050007000000045700000100030001000068008500010090000400
  # [8 1 2 7 5 3 6 4 9 9 4 3 6 8 2 1 7 5 6 7 5 4 9 1 2 8 3 1 5 4 2 3 7 8 9 6 3 6 9 8 4 5 7 2 1 2 8 7 1 6 9 5 3 4 5 2 1 9 7 4 3 6 8 4 3 8 5 2 6 9 1 7 7 9 6 3 1 8 4 5 2]
  # 
  #
  # @param puzzle string of numbers representing the 9x9 cells.
  # @return the jar's answer (most likely as a string).
  #
  def exec_sudoku_jar( puzzle )
    jar_answer = nil; 
    Dir.chdir( "#{ Rails.root }/lib/" ) do
      jar_answer = `java -jar sudoku.jar #{ puzzle }`;
    end 
    logger.debug "jar_answer:#{ jar_answer }";
    return jar_answer; 
  end

end
