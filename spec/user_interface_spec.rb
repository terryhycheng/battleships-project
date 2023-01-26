require "user_interface"

RSpec.describe UserInterface do
  describe "ship setup scenario" do
    it "allows the user to set up ships" do
      io = double(:io)
      game = double(:game, rows: 10, cols: 10)
      ship = double(:ship, length: 2)
      interface = UserInterface.new(io, game)
      expect(ship).to receive(:length).and_return(2)
      expect(io).to receive(:puts).with("Welcome to the game!")
      expect(io).to receive(:puts).with("Set up your ships first.")
      allow(game).to receive(:unplaced_ships).and_return([ship],[ship],[ship],[ship],[ship],[])
      expect(io).to receive(:puts).with("You have these ships remaining: 2")
      expect(io).to receive(:puts).with("Which do you wish to place?")
      expect(io).to receive(:gets).and_return("3\n")
      expect(io).to receive(:puts).with("There is no ship with the length: 3. Please enter again.")
      expect(io).to receive(:puts).with("You have these ships remaining: 2")
      expect(io).to receive(:puts).with("Which do you wish to place?")
      expect(io).to receive(:gets).and_return("2\n")
      expect(io).to receive(:puts).with("Vertical or horizontal? [vh]")
      expect(io).to receive(:gets).and_return("a\n")
      expect(io).to receive(:puts).with("Invalid input. Please try again.")
      expect(io).to receive(:puts).with("Vertical or horizontal? [vh]")
      expect(io).to receive(:gets).and_return("v\n")
      expect(io).to receive(:puts).with("Which row?")
      expect(io).to receive(:gets).and_return("3\n")
      expect(io).to receive(:puts).with("Which column?")
      expect(io).to receive(:gets).and_return("2\n")
      expect(io).to receive(:puts).with("OK.")
      expect(game).to receive(:place_ship).with({
        length: 2,
        orientation: :vertical,
        row: 3,
        col: 2
        })
      expect(io).to receive(:puts).with("This is your board now:")
      allow(game).to receive(:ship_at?).and_return(false)
      allow(game).to receive(:ship_at?).with(2, 3).and_return(true)
      allow(game).to receive(:ship_at?).with(2, 4).and_return(true)
      expect(io).to receive(:puts).with([
        "..........",
        "..........",
        ".S........",
        ".S........",
        "..........",
        "..........",
        "..........",
        "..........",
        "..........",
        ".........."
      ].join("\n"))
      interface.run
    end
  end
end
