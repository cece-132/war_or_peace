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

  describe '#deal(player1, player2)' do

    before :each do
      @player1 = Player.new("Megan")
      @player2 = Player.new("Aurora")

      @dealer.deal(@player1, @player2)
    end
    
    it 'deals two players an equal number of cards' do
      expect(@player1.deck.length).to eq 26
      expect(@player2.deck.length).to eq 26
      expect(@player1.deck).to_not eq @player2.deck
    end

    it 'every card in each players deck is a Card' do
      @player1.deck.each do |card|
        expect(card).to be_a Card
      end

      @player2.deck.each do |card|
        expect(card).to be_a Card
      end
    end

    it 'cards are not repeated in the other players deck' do
      expect(@player2.deck).to_not include(@player1.deck.first)
      expect(@player1.deck).to_not include(@player2.deck.first)
    end
  end
end