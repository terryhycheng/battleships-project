class Game
  attr_reader :rows, :cols, :unplaced_ships, :placed_ships, :hits, :misses

  def initialize(ships, rows = 10, cols = 10)
    @unplaced_ships = ships
    @placed_ships = []
    @rows = rows
    @cols = cols
    @hits = 0
    @misses = 0
  end

  def place_ship(*args)
    hash = args[0]
    ship = @unplaced_ships.select { |ship| ship.length == hash[:length] }[0]
    ship.set(hash[:orientation], hash[:row], hash[:col])
    @unplaced_ships.delete(ship)
    @placed_ships << ship
  end

  def ship_at?(x, y)
    arr = @placed_ships.map { |ship| ship.check_location(x,y) }
    return arr.include? true
  end

  def fire_at(x, y)
    @placed_ships.each do |ship|
      ship.check_hit(x, y) ? @hits += 1 : @misses += 1
    end
  end

  def end?
    arr = @placed_ships.map { |ship| ship.is_sunk? }
    return arr.all? true
  end
end
