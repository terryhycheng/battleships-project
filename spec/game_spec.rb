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
    game = Game.new([ship])
    game.place_ship({length: 2, orientation: :vertical, row: 3, col: 2})
    expect(game.ship_at?(2,3)).to be true
    expect(game.ship_at?(2,4)).to be true
    expect(game.ship_at?(1,3)).to be false
    expect(game.ship_at?(4,3)).to be false
    expect(game.ship_at?(2,5)).to be false
  end
end