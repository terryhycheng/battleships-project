require "game"

describe Game do
  it "returns the number of cols & rows of the game board" do
    ship = double :fake_ship
    game = Game.new([ship])
    expect(game.rows).to eq 10
    expect(game.cols).to eq 10
  end

  it "returns a list of unplaced ships" do
    ships = [double(:ship, length: 2), double(:ship, length: 5)]
    game = Game.new(ships)
    expect(game.unplaced_ships).to eq ships
  end
  
  it "sets attributes to a Ship object" do
    ship_1 = double :fake_ship, row: 3, col: 2, orientation: :vertical, length: 2
    ship_2 = double :fake_ship, row: 3, col: 2, orientation: :vertical, length: 5
    expect(ship_1).to receive(:set).with(:vertical, 3, 2)
    game = Game.new([ship_1, ship_2])
    game.place_ship({length: 2, orientation: :vertical, row: 3, col: 2})
    expect(game.unplaced_ships).to eq [ship_2]
    expect(game.placed_ships).to eq [ship_1]
    end
    
  it "returns true if the ship is on the location, false if not" do
    ship = double :fake_ship, row: 3, col: 2, orientation: :vertical, length: 2
    expect(ship).to receive(:set).with(:vertical, 3, 2)
    allow(ship).to receive(:check_location).and_return(true, true, false, false, false)
    game = Game.new([ship])
    game.place_ship({length: 2, orientation: :vertical, row: 3, col: 2})
    expect(game.ship_at?(2,3)).to be true
    expect(game.ship_at?(2,4)).to be true
    expect(game.ship_at?(1,3)).to be false
    expect(game.ship_at?(4,3)).to be false
    expect(game.ship_at?(2,5)).to be false
  end
  
  it "counts a hit when the user fires on the ship location" do
    ship = double :fake_ship, row: 3, col: 2, orientation: :vertical, length: 2
    expect(ship).to receive(:set).with(:vertical, 3, 2)
    allow(ship).to receive(:check_hit).and_return(true, true)
    game = Game.new([ship])
    game.place_ship({length: 2, orientation: :vertical, row: 3, col: 2})
    game.fire_at(2, 3)
    game.fire_at(2, 4)
    expect(game.hits).to eq 2
    expect(game.misses).to eq 0
  end
  
  it "counts a miss when the user fires on other location" do
    ship = double :fake_ship, length: 2
    expect(ship).to receive(:set).with(:vertical, 3, 2)
    allow(ship).to receive(:check_hit).and_return(false, false)
    game = Game.new([ship])
    game.place_ship({length: 2, orientation: :vertical, row: 3, col: 2})
    game.fire_at(2, 5)
    game.fire_at(3, 3)
    expect(game.hits).to eq 0
    expect(game.misses).to eq 2
  end
  
  it "ends the game if all ships are sunk" do
    ship_1 = double :fake_ship, length: 2
    ship_2 = double :fake_ship, length: 3
    expect(ship_1).to receive(:set).with(:vertical, 3, 2)
    expect(ship_2).to receive(:set).with(:vertical, 5, 4)
    allow(ship_1).to receive(:is_sunk?).and_return(true, true)
    allow(ship_2).to receive(:is_sunk?).and_return(false, true)
    game = Game.new([ship_1, ship_2])
    game.place_ship({length: 2, orientation: :vertical, row: 3, col: 2})
    game.place_ship({length: 3, orientation: :vertical, row: 5, col: 4})
    expect(game.end?).to be false
    expect(game.end?).to be true
  end
end