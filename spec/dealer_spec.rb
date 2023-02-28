require 'rspec'
require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'
require './lib/war_or_peace_runner'

RSpec.describe Dealer do

  before :each do
    @dealer = Dealer.new
  end
  
  describe 'initialize' do
    it 'exists' do
      expect(@dealer).to be_a Dealer
    end

    it 'has attributes' do
      expect(@dealer.deck).to be_a Array
      expect(@dealer.deck.length).to eq 52
    end
  end
end