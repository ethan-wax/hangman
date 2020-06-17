require 'json'

class Game

    def initialize(load, word=nil, current=nil, guesses=0, win=false, wrong=nil)
        unless load
            filename = '5desk.txt'
            words = File.readlines filename
            words.select! {|word| word.length >= 5 && word.length <= 12}
            @word = words.sample.chomp.split("")
            @current = Array.new(@word.length, "_")
            @guesses = 5
            @win = false
            @wrong_letters = []
        else
            @word=word
            @current=current
            @guesses=guesses
            @win=win
            @wrong_letters=wrong
        end
    end

    def play_game
        until @guesses == 0
            display()
            letter = guess_letter()
            check_letter(letter)
            if @current.none?("_")
                win()
                exit
            end
        end
        lose()
    end

    def guess_letter
        puts ""
        puts "Incorrect letters:"
        p @wrong_letters
        puts "Please input a letter and press enter:"
        letter = gets.chomp
        return letter
    end

    def check_letter(guess)
        unless @word.include?(guess)
            @wrong_letters.push(guess)
            @guesses -= 1
        else
            str = @word.map{|n| n}
            str.each_index do |index|
                if str[index] == guess
                    @current[index] = guess
                end
            end
        end
    end

    def display
        puts ""
        puts "#{@current}"
        puts ""
        puts "Guesses Remaingng: #{@guesses}"
    end

    def lose
        puts "The correct answer was #{@word.join("")}"
    end
    
    def win
        puts "Congrats, you win!"
    end
end

g = Game.new(true, ["h", "e", "l", "l", "o"], ["h", "_", "_", "_", "o"], 3, false, ["a", "b"])
g.play_game