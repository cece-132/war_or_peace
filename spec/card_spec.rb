require 'rspec'
require './lib/card'
require 'pry'

RSpec.describe Card do

  describe 'initialize(suit, value, rank)' do
    before :each do 
      @card = Card.new(:diamond, 'Queen', 12)
    end

    it 'exists and has attributes' do
      expect(@card).to be_a(Card)
    end

    it 'has attributes' do
      expect(@card.suit).to be_a Symbol
      expect(@card.suit).to eq(:diamond)

      expect(@card.value).to be_a String
      expect(@card.value).to eq('Queen')

      expect(@card.rank).to be_a Integer
      expect(@card.rank).to eq(12)
    end
  end

end
