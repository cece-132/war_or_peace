require './lib/dealer'

RSpec.describe Dealer do

  before :each do
    @dealer = Dealer.new
  end
  
  describe 'initialize' do
    it 'exists' do
      expect(@dealer).to be_a Dealer
    end

    it 'has attributes' do
      expect(@dealer.deck).to be_a Deck
      expect(@dealer.deck.cards.length).to eq 52
    end
  end
end