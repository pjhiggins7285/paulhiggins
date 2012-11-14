
class ChessBoard

  def initialize
    @nr_rows = 8
    @nr_cols = 8
    @squares = Array.new(@nr_rows *  @nr_cols)
  end

  def is_valid_square(pos)
    r = pos.rank
    c = pos.file
    is_valid_idx(r,c)
  end


  def get_piece_on(pos)
    unless is_valid_square(pos)
      return nil
    end
    @squares[get_idx(pos.rank, pos.file)]
  end

  def put_piece_on(piece, pos)
    @squares[get_idx(pos.rank, pos.file)] = piece
  end

  def is_valid_idx(r,c)
    r <= @nr_rows && c <= @nr_cols && r > 0 && c > 0
  end

  protected
  # NB: row and col are one-based, but stored in the array 0-based
  def get_idx(r, c)
    unless is_valid_idx(r, c)
      return nil
    end
    (r - 1 ) * @nr_cols + c - 1
  end

end
