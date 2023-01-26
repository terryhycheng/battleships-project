require "user_interface"

RSpec.describe UserInterface do
  describe "ship setup scenario" do
    it "allows the user to set up ships" do
      io = double(:io)
      game = double(:game, rows: 10, cols: 10)
      ship_2 = double(:ship, length: 2)
      ship_3 = double(:ship, length: 3)
      interface = UserInterface.new(io, game)
      allow(ship_2).to receive(:length).and_return(2)
      allow(ship_3).to receive(:length).and_return(3)
      expect(io).to receive(:puts).with("Welcome to the game!")
      expect(io).to receive(:puts).with("Set up your ships first.")
      allow(game).to receive(:unplaced_ships).and_return([ship_2, ship_3],[ship_2, ship_3],[ship_2, ship_3],[ship_2, ship_3],[ship_2, ship_3],[ship_3], [ship_3], [ship_3], [])
      expect(io).to receive(:puts).with("You have these ships remaining: 2, 3")
      expect(io).to receive(:puts).with("Which do you wish to place?")
      expect(io).to receive(:gets).and_return("5\n")
      expect(io).to receive(:puts).with("There is no ship with the length: 5. Please enter again.")
      expect(io).to receive(:puts).with("You have these ships remaining: 2, 3")
      expect(io).to receive(:puts).with("Which do you wish to place?")
      expect(io).to receive(:gets).and_return("2\n")
      expect(io).to receive(:puts).with("Vertical or horizontal? [vh]")
      expect(io).to receive(:gets).and_return("a\n")
      expect(io).to receive(:puts).with("Invalid input. Please try again.")
      expect(io).to receive(:puts).with("Vertical or horizontal? [vh]")
      expect(io).to receive(:gets).and_return("v\n")
      expect(io).to receive(:puts).with("Which row?")
      expect(io).to receive(:gets).and_return("10\n")
      expect(io).to receive(:puts).with("Which column?")
      expect(io).to receive(:gets).and_return("2\n")
      expect(game).to receive(:cols).and_return(10)
      expect(game).to receive(:rows).and_return(10)
      expect(io).to receive(:puts).with("The ship must be placed inside the borad. Please enter again.")
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
      expect(io).to receive(:puts).with("You have these ships remaining: 3")
      expect(io).to receive(:puts).with("Which do you wish to place?")
      expect(io).to receive(:gets).and_return("3\n")
      expect(io).to receive(:puts).with("Vertical or horizontal? [vh]")
      expect(io).to receive(:gets).and_return("h\n")
      expect(io).to receive(:puts).with("Which row?")
      expect(io).to receive(:gets).and_return("4\n")
      expect(io).to receive(:puts).with("Which column?")
      expect(io).to receive(:gets).and_return("2\n")
      expect(io).to receive(:puts).with("The ship cannot be overlapped. Please enter again.")
      expect(io).to receive(:puts).with("Which row?")
      expect(io).to receive(:gets).and_return("4\n")
      expect(io).to receive(:puts).with("Which column?")
      expect(io).to receive(:gets).and_return("5\n")
      expect(io).to receive(:puts).with("OK.")
      expect(game).to receive(:place_ship).with({
        length: 3,
        orientation: :horizontal,
        row: 4,
        col: 5
        })
      expect(io).to receive(:puts).with("This is your board now:")
      allow(game).to receive(:ship_at?).and_return(false)
      allow(game).to receive(:ship_at?).with(2, 3).and_return(false, true)
      allow(game).to receive(:ship_at?).with(2, 4).and_return(false, true)
      allow(game).to receive(:ship_at?).with(5, 4).and_return(false, true)
      allow(game).to receive(:ship_at?).with(6, 4).and_return(false, true)
      allow(game).to receive(:ship_at?).with(7, 4).and_return(false, true)
      expect(io).to receive(:puts).with([
        "..........",
        "..........",
        ".S........",
        ".S..SSS...",
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
