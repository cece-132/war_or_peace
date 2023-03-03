require './lib/play'

RSpec.describe Play do

  before :each do
    @player1 = Player.new("Megan")
    @player2 = Player.new("Aurora")
    @play = Play.new(@player1, @player2)
  end

  describe '#initialize(player1, player2)' do

    it 'creates players to play the game' do
      expect(@play).to be_a Play
    end

    it 'has attributes' do
      expect(@play.player1).to be_a Player
      expect(@play.player2).to be_a Player
    end
  end

  describe '#welcome_message' do

    xit 'should print a message to the screen' do
      message = "Welcome to War! (or Peace) This game will be played with 52 cards.
      ------------------------------------------------------------------"
      expect(@play.welcome_message).to eq(message)
    end
  end

  describe '#player_count(input)' do
    it 'determines the number of players' do
      # expect(@play.player_count("1")).to eq("Please type player ones name")
      # expect(@play.player_count(2)).to eq("Please type player ones name")
      # expect(@play.player_count("76")).to eq("Incorrect input. Please enter eithe a 1 or a 2")
    end
  end

end