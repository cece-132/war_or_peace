require 'rspec'
require './lib/deck'
#require 'pry'; binding.pry

RSpec.describe Deck do
  it "exists" do
    deck = Deck.new(@cards)
  #card = Card.new(:diamond, 'Queen', 12)
    expect(deck).to be_an_instance_of(Deck)
  end

  it "has cards" do
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Ace', 14)

    deck = Deck.new([card1, card2, card3])

    expect(deck.cards).to eq([card1, card2, card3])
  end

  it "has rank_of_card_at" do
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Ace', 14)

    deck = Deck.new([card1, card2, card3])

    expect(deck.rank_of_card_at(0)).to eq(12)
    expect(deck.rank_of_card_at(2)).to eq(14)
  end

  it "has high_ranking_cards" do
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Ace', 14)

    deck = Deck.new([card1, card2, card3])

    expect(deck.high_ranking_cards).to eq([card1, card3])
  end

  it "has percent_high_ranking" do
    card1 = Card.new(:diamond, 'Queen', 12)
    card2 = Card.new(:spade, '3', 3)
    card3 = Card.new(:heart, 'Ace', 14)

    deck = Deck.new([card1, card2, card3])

    expect(deck.percent_high_ranking).to eq(66.67)
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
