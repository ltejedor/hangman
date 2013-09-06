require './src/hangman_game.rb'
require 'rubygems'
gem 'shoulda-matchers'

describe HangmanGame do
  def new_game
    hangman = HangmanGame.new
    hangman.stub(:to_s)
    hangman.stub(:play_loop)
    hangman.stub(:print_instructions)
    return hangman
  end

  describe '#game_end' do
  	it 'sets the game over flag' do
  		hangman = new_game
  		hangman.game_end
  		expect(hangman.game_over).to eq(true)
  	end
  end

  describe '#lost' do
  	it 'should call game_end()' do
  		hangman = new_game
      hangman.play
  		hangman.should_receive(:game_end)
  		hangman.lost
  	end
  end

  describe '#play' do
    it 'should get a random word' do
      hangman = new_game
      hangman.instance_variable_get(:@word_list).each do |v|
        hangman.should { allow_value(v).for(:game_word) }
      end
      hangman.play
    end

    it 'should set game letters array' do
      hangman = new_game
      hangman.play
      expect(hangman.instance_variable_get(:@game_letters)).to eq(hangman.instance_variable_get(:@game_word).chars.to_a)
    end

    it 'should call the play loop' do
      hangman = new_game
      hangman.should_receive(:play_loop)
      hangman.play
    end
  end

  describe '#have_lives?' do
    it 'should return true if the player has lives remaining' do
      hangman = new_game
      hangman.instance_variable_set(:@turns, 7)
      expect(hangman.have_lives?).to eq(true)
    end

    it 'should return false if the player has no lives remaining' do
      hangman = new_game
      hangman.instance_variable_set(:@turns, 0)
      expect(hangman.have_lives?).to eq(false)
    end
  end

  describe '#won?' do
    it 'should return true if victory conditions are met' do
      hangman = new_game
      hangman.play
      hangman.instance_variable_set(:@guessed_letters, hangman.instance_variable_get(:@game_letters))
      expect(hangman.won?).to eq(true)
    end

    it 'should continue if victory conditions are not met' do
      hangman = new_game
      hangman.play
      hangman.instance_variable_set(:@guessed_letters, 'doesnotexist'.chars.to_a)
      hangman.should_not_receive(:game_end)
      expect(hangman.won?).to eq(false)
    end
  end
end
