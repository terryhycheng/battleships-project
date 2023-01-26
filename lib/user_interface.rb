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

  def check_isInvalid_position(length, orientation, row, col)
    if check_isOutside_borad(length, orientation, row, col)
      show "The ship must be placed inside the borad. Please enter again."
      return true
    end
    
    if check_isOverlapped(length, orientation, col, row)
      show "The ship cannot be overlapped. Please enter again."
      return true
    end
    
    return false
  end
  
  # returns true if ship is overlapped
  def check_isOverlapped(length, orientation, x, y)
    if orientation == "v"
      (y.to_i...(y.to_i + length.to_i)).map{ |each_y| @game.ship_at?(x.to_i, each_y) }.include?(true)
    else
      (x.to_i...(x.to_i + length.to_i)).map{ |each_x| @game.ship_at?(each_x, y.to_i) }.include?(true)
    end
  end
  
  # returns true if it's outside the borad
  def check_isOutside_borad(length, orientation, row, col)
    if orientation == "v"
      @game.cols < col.to_i || @game.rows < (row.to_i + length.to_i)
    else
      @game.cols < (col.to_i + length.to_i) || @game.rows < row.to_i
    end
  end

  def ships_unplaced_message
    return @game.unplaced_ships.map do |ship|
      "#{ship.length}"
    end.join(", ")
  end

  def check_isInvalid_ship(length)
    return @game.unplaced_ships.select { |ship| ship.length == length.to_i }.empty?
  end

  def prompt_for_ship_placement
    ship_length = prompt("Which do you wish to place?", /^\d+$/)
    while check_isInvalid_ship(ship_length)
      show "There is no ship with the length: #{ship_length}. Please enter again."
      show "You have these ships remaining: #{ships_unplaced_message}"
      ship_length = prompt("Which do you wish to place?", /^\d+$/)
    end
    ship_orientation = prompt("Vertical or horizontal? [vh]", /^[vh]$/)
    ship_row = prompt("Which row?", /^\d+$/)
    ship_col = prompt("Which column?", /^\d+$/)
    while check_isInvalid_position(ship_length, ship_orientation, ship_row, ship_col)
      ship_row = prompt("Which row?", /^\d+$/)
      ship_col = prompt("Which column?", /^\d+$/)
    end
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
