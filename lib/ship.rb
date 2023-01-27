class Ship
  attr_reader :length, :orientation, :row, :col, :hits

  def initialize(length)
    @length = length
    @orientation = nil
    @row = nil
    @col = nil
    @hits = 0
  end

  def set(orientation, row, col)
    @orientation = orientation
    @row = row
    @col = col
  end

  def is_sunk?
    return @hits >= @length
  end

  def check_location(x, y)
    if @orientation == :vertical
        return (@row...(@row + @length)).include?(y) && @col == x
      else
        return (@col...(@col + @length)).include?(x) && @row == y
      end
  end

  def check_hit(x, y)
    is_hit = check_location(x, y)
    @hits += 1 if is_hit
    return is_hit
  end

end