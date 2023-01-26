require "user_interface"
require "ship"
require "game"

RSpec.describe UserInterface do
  before(:each) do
    @ship_choices = [2, 3].map { |length| Ship.new(length) }
    @game = Game.new(@ship_choices)
    @io = Kernel
    @interface = UserInterface.new(@io, @game)
  end

  describe "ship setup scenario" do
    it "allows the user to set up ships" do
      expect(@io).to receive(:puts).with("Welcome to the game!")
      expect(@io).to receive(:puts).with("Set up your ships first.")
      expect(@io).to receive(:puts).with("You have these ships remaining: 2, 3")
      expect(@io).to receive(:puts).with("Which do you wish to place?")
      expect(@io).to receive(:gets).and_return("2\n")
      expect(@io).to receive(:puts).with("Vertical or horizontal? [vh]")
      expect(@io).to receive(:gets).and_return("v\n")
      expect(@io).to receive(:puts).with("Which row?")
      expect(@io).to receive(:gets).and_return("3\n")
      expect(@io).to receive(:puts).with("Which column?")
      expect(@io).to receive(:gets).and_return("2\n")
      expect(@io).to receive(:puts).with("OK.")
      expect(@io).to receive(:puts).with("You have these ships remaining: 3")
      expect(@io).to receive(:puts).with("Which do you wish to place?")
      expect(@io).to receive(:gets).and_return("3\n")
      expect(@io).to receive(:puts).with("Vertical or horizontal? [vh]")
      expect(@io).to receive(:gets).and_return("h\n")
      expect(@io).to receive(:puts).with("Which row?")
      expect(@io).to receive(:gets).and_return("4\n")
      expect(@io).to receive(:puts).with("Which column?")
      expect(@io).to receive(:gets).and_return("5\n")
      expect(@io).to receive(:puts).with("OK.")
      expect(@io).to receive(:puts).with("This is your board now:")
      expect(@io).to receive(:puts).with([
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
      @interface.run
    end
  end
end
