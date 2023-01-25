class Ship
  attr_reader :length, :orientation, :row, :col

  def initialize(length)
    @length = length
    @orientation = nil
    @row = nil
    @col = nil
  end

  def set(orientation, row, col)
    @orientation = orientation
    @row = row
    @col = col
  end
end