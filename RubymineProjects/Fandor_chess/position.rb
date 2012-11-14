##
# Position - a (rank, file) pair on the chessboard
# Rank = 1 => white piece, Rank 2=>white pawns Rank=7=>black pawns etc
# Position(1,1) = white queen's rook

class Position
  def initialize(r, f)
    @rank = r
    @file = f
  end
  attr_accessor :rank, :file
end
