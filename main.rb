require_relative 'game'

def valid_input?(input)
    unless input == "start" || input == "load"
        return false
    else
        return true
    end
end

puts "Please input 'start' to begin a new game or 'load' to return to a previous one:"
input = gets.chomp
until valid_input?(input)
    puts "Please enter a valid input:"
    input = gets.chomp
end
if input == "start"
    g = Game.new(false)
else
    file = File.open('load.txt', 'r')
    contents = file.read
    g = Game.from_json(contents)
end

g.play_game