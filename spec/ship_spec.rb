require "ship"

describe Ship do
  before(:each) do
    @ship = Ship.new(5)
  end


  it "initialises a ship with a given length" do
    expect(@ship.length).to eq 5
    expect(@ship.orientation).to be nil
    expect(@ship.col).to be nil
    expect(@ship.row).to be nil
  end

  it "sets the ship up with given arguments" do
    @ship.set(:vertical, 5, 2)
    expect(@ship.length).to eq 5
    expect(@ship.orientation).to eq :vertical
    expect(@ship.col).to eq 2
    expect(@ship.row).to eq 5
  end
end