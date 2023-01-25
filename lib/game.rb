class Game
  attr_reader :rows, :cols, :unplaced_ships, :placed_ships

  def initialize(ships, rows = 10, cols = 10)
    @unplaced_ships = ships
    @placed_ships = []
    @rows = rows
    @cols = cols
  end

  def place_ship(*args)
    hash = args[0]
    ship = @unplaced_ships.select{ |ship| ship.length == hash[:length] }[0]
    ship.set(hash[:orientation], hash[:row], hash[:col])
    @unplaced_ships.delete(ship)
    @placed_ships << ship
  end

  def ship_at?(x, y)
    arr = []
    @placed_ships.each do |ship|
      if ship.orientation == :vertical
        (ship.row...(ship.row + ship.length)).include?(y) && ship.col == x && arr << true
      else
        (ship.col...(ship.col + ship.length)).include?(x) && ship.row == y && arr << true
      end
    end
    return arr.include? true
  end
end
