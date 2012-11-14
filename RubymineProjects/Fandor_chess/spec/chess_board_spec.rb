require "rspec"
require "../position"
require "../chess_board"

describe "ChessBoard" do

  before :each do
    @board = ChessBoard.new
  end

  describe "new"
  it "should define a properly sized board, empty" do
    @board.should be_an_instance_of ChessBoard
    @board.get_piece_on(Position.new(1,1)).should == nil
    @board.get_piece_on(Position.new(0,1)).should == nil
    @board.get_piece_on(Position.new(100,100)).should == nil
    @board.is_valid_square(Position.new(0,0)).should == false
    @board.is_valid_square(Position.new(1,1)).should == true
    @board.is_valid_square(Position.new(1,8)).should == true
    @board.is_valid_square(Position.new(1,9)).should == false
    @board.is_valid_square(Position.new(8,8)).should == true
    @board.is_valid_square(Position.new(9,8)).should == false
    @board.is_valid_square(Position.new(9,9)).should == false
  end

  describe "putpiece"
  it "should should return an object put on a square" do
    @board.get_piece_on(Position.new(1,1)).should == nil
    @board.put_piece_on(1, Position.new(1,1))
    @board.get_piece_on(Position.new(1,1)).should == 1
  end


end