class Game

    def initialize
        filename = '5desk.txt'
        words = File.readlines filename
        words.select! {|word| word.length >= 5 && word.length <= 12}
        @word = words.sample.chomp.split("")
        @current = Array.new(@word.length, "_")
        @guesses = 5
        @win = false
        @wrong_letters = []
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

g = Game.new
g.play_game