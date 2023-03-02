require './lib/player'

RSpec.describe Player do

  before :each do
    @card1 = Card.new(:diamond, 'Queen', 12)
    @card2 = Card.new(:spade, '3', 3)
    @card3 = Card.new(:heart, 'Ace', 14)

    @deck = [@card1, @card2, @card3]

    @player = Player.new('Clarisa', @deck)
  end

  describe '#initialize(name, deck)' do
    it 'exists' do
      expect(@player).to be_an_instance_of(Player)
    end

    it 'has attributes' do
      expect(@player.name).to eq("Clarisa")
      expect(@player.deck.cards).to eq [@card1, @card2, @card3]
    end

    describe 'relationships' do
      it 'relationship to Deck' do
        expect(@player.deck).to be_a Deck
      end

      it 'has relationship to Card' do
        @player.deck.cards.each do |card|
          expect(card).to be_a Card
        end
      end
    end

  end

  describe '#has_lost?' do
    it 'returns boolean whether a player has lost or not' do
      expect(@player.has_lost?).to eq(false)
    end

    it 'if player loses all cards the player has lost' do
      @player.deck.remove_card
      @player.deck.remove_card
      @player.deck.remove_card
  
      expect(@player.has_lost?).to eq(true)
    end
  end

end
