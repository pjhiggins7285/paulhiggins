#Module Chess


class ChessPiece
    def initialize(color, board)
    @color = color
    @board = board
    end
    attr_accessor :pos, :is_initial_pos, :color

    # opposition - check if the piece is opposite player's
    def opposition(piece)
      @color != piece.color
    end


    # move_legal? checks  that the piece can move to position
    # possibly capturing an opposition piece
    def is_move_legal(pos)
      unless @board.is_valid_square(pos)
        return false
      end
      occupied = @board.get_piece_on(pos)
      if (occupied != nil)  && opposition(occupied)
        return can_capture(pos)
      end
      can_move_to(pos)
    end

    # move a piece from one position to another
    def move_pos(p)
      @pos = p
      @board.put_piece_on(nil, @pos)
      @board.put_piece_on(self, pos)
      @is_initial_pos = false
    end

    #place a piece to start on a position
    def init_pos(p)
      @pos = p
      @board.put_piece_on(self, pos)
      @is_initial_pos = true
    end

    #white pieces move to higher ranks, black pieces to lower ranks
    def direction
      (@color == :white) ? 1 : -1
    end

    # can_move_to : check if the piece can move from @pos to pos.
    # dont worry if final pos is occupied, but check intermediate squares
    protected
    def can_move_to(pos)
      #override this for each piece
      true
    end

    # can_capture : check if the piece can capture the occupier
    def can_capture(pos)
      #override if there are special capture rules
      #doesn't call opposition()
      true
    end

end

##
# class Pawn implements the special rules for pawns
#
class Pawn < ChessPiece
  # can_move_to - implement the well-known pawn rules
  def can_move_to(p)
    if @pos.file != p.file
      return false  # pawns always move on the same rank
    end
    if p.rank == @pos.rank+direction
      return true
    end
    if is_initial_pos && (p.rank == @pos.rank + 2 * direction)
      if @board.get_piece_on(Position.new(@pos.rank+1, @pos.file)) != nil
        return false  #trying to move through an occupied square
      else
        return true
      end
  end
    false
  end

  def can_capture(pos)
    nextto = ((pos.file == (@pos.file + 1)) || (pos.file == (@pos.file-1)))
    forward = (pos.rank == (@pos.rank + direction))
   (nextto && forward)
  end
end
