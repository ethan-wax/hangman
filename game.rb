require 'json'

class Game

    def initialize(load, word=nil, current=nil, guesses=0, win=false, wrong=nil)
        unless load
            file = File.open('5desk.txt', 'r')
            words = file.readlines
            file.close
            words.select! {|word| word.length >= 5 && word.length <= 12}
            @word = words.sample.chomp.split("")
            @current = Array.new(@word.length, "_")
            @guesses = 5
            @win = false
            @wrong_letters = []
        else
            @word = word
            @current = current
            @guesses = guesses
            @win = win
            @wrong_letters = wrong
        end
    end

    def play_game
        until @guesses == 0
            display()
            letter = guess_letter()
            save() if letter == "save"
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
        puts "Please input a letter and press enter or input 'save' to save and exit:"
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
        puts ""
        puts "#{@current}"
        puts ""
        puts "The correct answer was #{@word.join("")}"
    end
    
    def win
        puts ""
        puts "#{@current}"
        puts ""
        puts "Congrats, you win!"
    end

    def to_json
        JSON.dump ({
            :word => @word,
            :current => @current,
            :guesses => @guesses,
            :win => @win,
            :wrong => @wrong_letters
        })
    end

    def self.from_json(string)
        data = JSON.load string
        self.new(true, data['word'], data['current'], data['guesses'], data['win'], data['wrong'])
    end

    def save
        game = to_json
        file = File.open('load.txt', 'w')
        file.puts(game)
        file.close
        exit
    end 
end
