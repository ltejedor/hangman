class HangmanGame

	attr_reader :game_word

	def initialize
		number = rand(5)
		@number = number
	end

	def play

		set_word
		print_instructions

		correct = false

		game_letters = @game_word.chars.to_a

		game_over = false

		guessed_letters = []

		turns = 7
		@turns = turns

		while game_over == false
			letter = gets.chomp.downcase
			counter = @game_word.size

			if @turns > 1
				puts "Guess another letter"
				if letter.size != 1
					puts "This is not a valid input foolish human"
				elsif guessed_letters.include? letter
					puts "You have already guessed the letter #{letter} silly mortal"
				elsif game_letters.include? letter
					puts "Yes, this word does include #{letter}, but you shall not defeat me"
				else
					@turns = @turns - 1
					puts "Nope loser. You have #{@turns} guesses left."
				end

				guessed_letters << letter

				game_letters.each do |l|
					if guessed_letters.include? l
						print "#{l} "
					else
						print "__ "
					end
				end
				puts ""

				game_letters.each do |l|
					if guessed_letters.include? l
						counter = counter - 1
						if counter == 0
							puts "You are victorious! Claim your prize foul beast."
							puts "The word was in fact #{@game_word}"
							game_over = true
						end
					end
				end

			else
				puts "What a loser"
				puts "The word was obviously #{@game_word}"
				game_over = true
			end
		end

	end


	def set_word
		words = ["hello", "hangman", "meta", "dog", "starship", "food"]
		@game_word = words[@number]
	end

	def print_instructions
		puts "Welcome to Hangman, where I, the computer, am champion of words"
		puts "Guess a letter, if you dare"
		puts "__ " * @game_word.size
	end

end

HangmanGame.new.play


