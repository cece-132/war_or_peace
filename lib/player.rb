require './lib/deck'
require './lib/play'
require 'pry'

class Player
attr_reader :name, :deck
  def initialize(name, deck = [])
    @name = name
    @deck = Deck.new(deck)
  end

  def has_lost?
    if deck.cards.empty?
      true
    else
      false
    end
  end

end
