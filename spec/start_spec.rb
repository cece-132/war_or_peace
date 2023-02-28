require './lib/play'

RSpec.describe Play do

  describe 'initialize(p1_name, p2_name)' do

    before :each do
      @play = Play.new('Marie', 'Aurora')
    end

    it 'creates players to play the game' do
      expect(@play).to be_a Play
    end

    it 'has attributes' do
      expect(@play.player1).to be_a Player
      expect(@play.player2).to be_a Player
    end
  end

end