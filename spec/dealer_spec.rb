require './lib/dealer'
require 'pry'

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

  describe '#shuffle' do
    it 'can shuffle the deck of cards' do
      unshuffled_deck = Dealer.new.deck

      @dealer.shuffle

      expect(unshuffled_deck).to_not eq @dealer.deck
    end
  end
end