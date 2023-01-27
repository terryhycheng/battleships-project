require "ship"

describe Ship do
  before(:each) do
    @ship = Ship.new(3)
  end

  it "initialises a ship with a given length" do
    expect(@ship.length).to eq 3
    expect(@ship.orientation).to be nil
    expect(@ship.col).to be nil
    expect(@ship.row).to be nil
  end

  it "sets the ship up with given arguments" do
    @ship.set(:vertical, 5, 2)
    expect(@ship.length).to eq 3
    expect(@ship.orientation).to eq :vertical
    expect(@ship.col).to eq 2
    expect(@ship.row).to eq 5
  end

  it "returns true when a ship is on the location" do
    @ship.set(:vertical, 5, 2)
    expect(@ship.check_location(2, 5)).to be true
    expect(@ship.check_location(2, 6)).to be true
    expect(@ship.check_location(2, 7)).to be true
    expect(@ship.check_location(2, 8)).to be false
    expect(@ship.check_location(3, 5)).to be false
  end

  it "checks if the ship is sunk" do
    @ship.set(:vertical, 5, 2)
    expect(@ship.is_sunk?).to be false
    @ship.check_hit(1, 3)
    expect(@ship.hits).to eq 0
    @ship.check_hit(2, 5)
    @ship.check_hit(2, 6)
    expect(@ship.hits).to eq 2
    @ship.check_hit(2, 7)
    expect(@ship.is_sunk?).to be true
  end
end