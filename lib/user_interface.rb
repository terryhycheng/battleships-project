class UserInterface
  def initialize(io, game)
    @io = io
    @game = game
  end

  def run
    show "Welcome to the game!"
    show "Set up your ships first."
    while !@game.unplaced_ships.empty?
      show "You have these ships remaining: #{ships_unplaced_message}"
      prompt_for_ship_placement
    end
    show "This is your board now:"
    show format_board
  end

  private

  def show(message)
    @io.puts(message)
  end
  
  def prompt(message, type)
    show message
    user_answer = @io.gets.chomp
    if user_answer =~ type
      return user_answer
    else
      show "Invalid input. Please try again."
      prompt(message, type)
    end
  end

  def ships_unplaced_message
    return @game.unplaced_ships.map do |ship|
      "#{ship.length}"
    end.join(", ")
  end

  def check_ship_exist(length)
    return !@game.unplaced_ships.select { |ship| ship.length == length.to_i }.empty?
  end

  def prompt_for_ship_placement
    ship_length = prompt("Which do you wish to place?", /^\d+$/)
    while !check_ship_exist(ship_length)
      show "There is no ship with the length: #{ship_length}. Please enter again."
      show "You have these ships remaining: #{ships_unplaced_message}"
      ship_length = prompt("Which do you wish to place?", /^\d+$/)
    end
    ship_orientation = prompt("Vertical or horizontal? [vh]", /^[vh]$/)
    ship_row = prompt("Which row?", /^\d+$/)
    ship_col = prompt("Which column?", /^\d+$/)
    show "OK."
    @game.place_ship(
      length: ship_length.to_i,
      orientation: {"v" => :vertical, "h" => :horizontal}.fetch(ship_orientation),
      row: ship_row.to_i,
      col: ship_col.to_i
    )
  end

  def format_board
    return (1..@game.rows).map do |y|
      (1..@game.cols).map do |x|
        next "S" if @game.ship_at?(x, y)
        next "."
      end.join
    end.join("\n")
  end
end
