require "rspec"
require "../chess_piece"
require "../position"
require "../chess_board"

describe "ChessPiece" do

  before :each do   #test setup
    @board = ChessBoard.new
    @white_piece = ChessPiece.new(:white, @board)
    @black_piece = ChessPiece.new(:black, @board)
  end

  describe #new
  it "should be a chess piece" do
    @white_piece.should be_an_instance_of ChessPiece
  end

  describe #putpos
  it "should be on the position where it was initially put" do
    p = Position.new(1,2)
    @white_piece.init_pos(p)
    @white_piece.pos.rank.should == 1
    @white_piece.pos.file.should == 2
    @white_piece.is_initial_pos.should == true
  end

  describe #movepos
  it "should be on the position where it was moved" do
    p = Position.new(1,2)
    @white_piece.init_pos(p)
    p = Position.new(2,3)
    @white_piece.move_pos(p)
    @white_piece.pos.rank.should == 2
    @white_piece.pos.file.should == 3
    @white_piece.is_initial_pos.should == false
  end

  describe #color
  it "should have the correct color" do
    @white_piece.color.should == :white
    @black_piece.color.should == :black
  end

  describe #is_legal_move
  it "should return true for legal_move on base class" do
    p = Position.new(1,1)
    @white_piece.is_move_legal(p).should == true
    puts "In test"
  end

end

describe "Pawn"  do

before :each do  # test setup
  @board = ChessBoard.new
  @white_pawn = Pawn.new(:white, @board)
  @black_pawn = Pawn.new(:black, @board)
  end

  describe #is_legal_move
  it "should allow white pawn in initial square to move one or two" do
    p = Position.new(2,1)
    @white_pawn.init_pos(p)
    @white_pawn.is_move_legal(p).should == false
    p2 = Position.new(3,1)
    @white_pawn.is_move_legal(p2).should == true
    p2 = Position.new(4,1)
    @white_pawn.is_move_legal(p2).should == true
    p2 = Position.new(5,1)
    @white_pawn.is_move_legal(p2).should == false
    p2 = Position.new(3,2)
    @white_pawn.is_move_legal(p2).should == false
    p2 = Position.new(1,1)
    @white_pawn.is_move_legal(p2).should == false
  end

describe #is_legal_move
it "should allow white pawn to move one square if it moved already" do
  p = Position.new(2,1)
  @white_pawn.init_pos(p)
  p = Position.new(3,1)
  @white_pawn.move_pos(p)
  @white_pawn.is_move_legal(p).should == false
  p2 = Position.new(4,1)
  @white_pawn.is_move_legal(p2).should == true
  p2 = Position.new(5,1)
  @white_pawn.is_move_legal(p2).should == false
  p2 = Position.new(3,2)
  @white_pawn.is_move_legal(p2).should == false
  p2 = Position.new(1,1)
  @white_pawn.is_move_legal(p2).should == false
end

  describe #is_legal_move
  it "should allow black pawn in initial square to move one or two" do
    p = Position.new(7, 1)
    @black_pawn.init_pos(p)
    @black_pawn.is_move_legal(p).should == false
    p2 = Position.new(6, 1)
    @black_pawn.is_move_legal(p2).should == true
    p2 = Position.new(5, 1)
    @black_pawn.is_move_legal(p2).should == true
    p2 = Position.new(4, 1)
    @black_pawn.is_move_legal(p2).should == false
    p2 = Position.new(7, 2)
    @black_pawn.is_move_legal(p2).should == false
    p2 = Position.new(8, 1)
    @black_pawn.is_move_legal(p2).should == false
  end

describe #is_legal_move
it "should not allow pawn onto or through a piece" do
  p = Position.new(2,1)
  @white_pawn.init_pos(p)
  p2 = Position.new(3,1)
  @black_pawn.move_pos(p2)
  # cant move to an occupied space
  @white_pawn.is_move_legal(p2).should == false
  @black_pawn.is_move_legal(p).should == false
  #cant move through an occupied space
  p2 = Position.new(4,1)
  @white_pawn.is_move_legal(p2).should == false
  @white_pawn2 = Pawn.new(:white, @board)
  @white_pawn2.move_pos(p2)
  @white_pawn.is_move_legal(p2).should == false
end

describe #is_legal_move
it "should be able to capture a piece on the diagonal" do
  p = Position.new(2,2)
  @white_pawn.init_pos(p)
  p2 = Position.new(3,3)
  @black_pawn.move_pos(p2)
  # check for capture rules
  @white_pawn.is_move_legal(p2).should == true
  @black_pawn.is_move_legal(p).should == true
  #check other side
  p2 = Position.new(3,1)
  @black_pawn.move_pos (p2)
  @white_pawn.is_move_legal(p2).should == true
  @black_pawn.is_move_legal(p).should == true

  # cannot capture same color pawn
  white_pawn2 = Pawn.new(:white, @board)
  white_pawn2.move_pos(p2)
  @white_pawn.is_move_legal(p2).should == false
end

end
