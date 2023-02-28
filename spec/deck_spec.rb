require 'rspec'
require './lib/deck'
#require 'pry'; 

RSpec.describe Deck do

  before :each do
    @card1 = Card.new(:diamond, 'Queen', 12)
    @card2 = Card.new(:spade, '3', 3)
    @card3 = Card.new(:heart, 'Ace', 14)
    @card4 = Card.new(:club, '5', 5)

    @cards = [@card1, @card2, @card3]

    @deck = Deck.new(@cards)
  end

  describe '#initialize(cards)' do
    it "exists" do
      expect(@deck).to be_an_instance_of(Deck)
    end

    it 'has attributes' do
      expect(@deck.cards).to be_a Array
      expect(@deck.cards.length).to eq(3)
    end
  end

  describe '#rank_of_card_at(index)' do
    it 'returns the rank of card at index' do
      expect(@deck.rank_of_card_at(0)).to eq(12)
      expect(@deck.rank_of_card_at(2)).to eq(14)
    end
  end

  describe '#high_ranking_cards' do
    it 'returns cards in deck that rank 11 or higher' do
      expect(@deck.high_ranking_cards).to eq([@card1, @card3])
      expect(@deck.high_ranking_cards).to_not include(@card2)
      expect(@deck.high_ranking_cards).to_not include(@card4)
    end
  end

  describe '#percent_high_ranking' do 
    it 'return the percentage of cards that are high ranking' do
      expect(@deck.percent_high_ranking).to eq(66.67)
    end
  end

  it "does remove_card" do
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Ace', 14)

    deck = Deck.new([card1, card2, card3])

    expect(deck.cards).to eq([card1, card2, card3])

    deck.remove_card

    expect(deck.cards).to eq([card2, card3])
  end

  it "does add_card" do
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Ace', 14)
    card4 = Card.new(:club, '5', 5)

    deck = Deck.new([card1, card2, card3])

    expect(deck.cards).to eq([card1, card2, card3])

    deck.add_card(card4)

    expect(deck.cards).to eq([card1, card2, card3, card4])
  end
end
