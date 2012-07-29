require 'test_helper'

class SudokuControllerTest < ActionController::TestCase
  test "should get solve" do
    get :solve
    assert_response :success
  end

# test "should get the expected sudoku.jar response" do
#   controller = SudokuController.new;
#   jar_answer = controller.exec_sudoku_jar( "8892254389751803921" );
#   expected = "[8 1 2 7 5 3 6 4 9 9 4 3 6 8 2 1 7 5 6 7 5 4 9 1 2 8 3 1 5 4 2 3 7 8 9 6 3 6 9 8 4 5 7 2 1 2 8 7 1 6 9 5 3 4 5 2 1 9 7 4 3 6 8 4 3 8 5 2 6 9 1 7 7 9 6 3 1 8 4 5 2]";
#   assert jar_answer == expected;
# end

# test "get solution_to_puzzle should normalize the jar's response to be a string of digits representing the 9x9 block of sudoku cells" do 
#   controller = SudokuController.new;
#   puzzle = "800000000003600000070090200050007000000045700000100030001000068008500010090000400";
#   answer = controller.get_solution_to_puzzle( puzzle ); 
#   expected = "812753649943682175675491283154237896369845721287169534521974368438526917796318452";
#   assert answer == expected;
# end

end
