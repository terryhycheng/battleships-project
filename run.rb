$LOAD_PATH << "lib"
require "game"
require "user_interface"
require "ship"

class TerminalIO
  def gets
    return Kernel.gets
  end

  def puts(message)
    Kernel.puts(message)
  end
end

ship_choices = [2, 3].map { |length| Ship.new(length) }

io = TerminalIO.new
game = Game.new(ship_choices)
user_interface = UserInterface.new(io, game)
user_interface.run
