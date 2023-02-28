require './lib/turn'

RSpec.describe Turn do

  describe 'initialize(player1, player2)' do

    before :each do
      @card1 = Card.new(:diamond, 'Queen', 12)
      @card2 = Card.new(:spade, '3', 3)
      @card5 = Card.new(:heart, '8', 8)
      @card8 = Card.new(:diamond, '2', 2)
      
      @card3 = Card.new(:heart, 'Ace', 14)
      @card4 = Card.new(:diamond, 'Jack', 11)
      @card6 = Card.new(:diamond, 'Queen', 12)
      @card7 = Card.new(:heart, '3', 3)
  
      @deck1 = Deck.new([@card1, @card2, @card5, @card8])
      @deck2 = Deck.new([@card3, @card4, @card6, @card7])
  
      @player1 = Player.new("Megan", @deck1)
      @player2 = Player.new("Aurora", @deck2)
  
      @turn = Turn.new(@player1, @player2)
    end

    it 'exists' do
      expect(@turn).to be_an_instance_of(Turn)
    end

    it 'has attributes' do
      expect(@turn.player1).to be_a Player
      expect(@turn.player2).to be_a Player
      expect(@turn.spoils_of_war).to be_a Array
    end
  end

  describe '#type' do
    it 'returns :basic when players rank of card at index 0 are not the same' do
      card1 = Card.new(:diamond, 'Queen', 12)
      card2 = Card.new(:spade, '3', 3)
      card5 = Card.new(:heart, '8', 8)
      card8 = Card.new(:diamond, '2', 2)
      
      card3 = Card.new(:heart, 'Ace', 14)
      card4 = Card.new(:diamond, 'Jack', 11)
      card6 = Card.new(:diamond, 'Queen', 12)
      card7 = Card.new(:heart, '3', 3)
  
      deck1 = Deck.new([card1, card2, card5, card8])
      deck2 = Deck.new([card3, card4, card6, card7])
  
      player1 = Player.new("Megan", deck1)
      player2 = Player.new("Aurora", deck2)
  
      turn = Turn.new(player1, player2)

      expect(turn.type).to eq(:basic)
    end

    it 'returns :war when players rank of card at index 0 ar the same' do
      card1 = Card.new(:heart, 'Jack', 11)
      card2 = Card.new(:heart, '10', 10)
      card3 = Card.new(:heart, '9', 9)
      card4 = Card.new(:diamond, 'Jack', 11)
      card5 = Card.new(:heart, '8', 8)
      card6 = Card.new(:diamond, 'Queen', 12)
      card7 = Card.new(:heart, '3', 3)
      card8 = Card.new(:diamond, '2', 2)

      deck1 = Deck.new([card1, card2, card5, card8])
      deck2 = Deck.new([card4, card3, card6, card7])

      player1 = Player.new("Megan", deck1)
      player2 = Player.new("Aurora", deck2)
      
      turn = Turn.new(player1, player2)
      expect(turn.type).to eq(:war)
    end

    it 'returns :mutually_assured_destruction when rank of card at index 0 and at index 2 are the same' do
      card1 = Card.new(:heart, 'Jack', 11)
      card2 = Card.new(:heart, '10', 10)
      card3 = Card.new(:heart, '9', 9)
      card4 = Card.new(:diamond, 'Jack', 11)
      card5 = Card.new(:heart, '8', 8)
      card6 = Card.new(:diamond, '8', 8)
      card7 = Card.new(:heart, '3', 3)
      card8 = Card.new(:diamond, '2', 2)

      deck1 = Deck.new([card1, card2, card5, card8])
      deck2 = Deck.new([card4, card3, card6, card7])

      player1 = Player.new("Megan", deck1)
      player2 = Player.new("Aurora", deck2)

      turn = Turn.new(player1, player2)

      expect(turn.type).to eq(:mutually_assured_destruction)
    end
  end

  describe '#winner' do
    describe 'a :basic turn type' do
      it 'returns the player with the higher ranking card at index 0' do
        card1 = Card.new(:diamond, 'Queen', 12)
        card2 = Card.new(:spade, '3', 3)
        card5 = Card.new(:heart, '8', 8)
        card8 = Card.new(:diamond, '2', 2)
        
        card4 = Card.new(:diamond, 'Jack', 11)
        card3 = Card.new(:heart, 'Ace', 14)
        card6 = Card.new(:diamond, 'Queen', 12)
        card7 = Card.new(:heart, '3', 3)
  
        deck1 = Deck.new([card1, card2, card5, card8])
        deck2 = Deck.new([card4, card3, card6, card7])
  
        player1 = Player.new("Megan", deck1)
        player2 = Player.new("Aurora", deck2)
    
        turn = Turn.new(player1, player2)

        expect(turn.winner).to be_a Player
        expect(turn.winner).to eq(player1)
      end
    end

    describe 'a :war turn type' do
      it 'return the player with higher card at index 2' do
        card1 = Card.new(:heart, 'Jack', 11)
        card2 = Card.new(:heart, '10', 10)
        card5 = Card.new(:heart, '8', 8)
        card8 = Card.new(:diamond, '2', 2)

        card4 = Card.new(:diamond, 'Jack', 11)
        card3 = Card.new(:heart, '9', 9)
        card6 = Card.new(:diamond, 'Queen', 12)
        card7 = Card.new(:heart, '3', 3)
  
        deck1 = Deck.new([card1, card2, card5, card8])
        deck2 = Deck.new([card4, card3, card6, card7])
  
        player1 = Player.new("Megan", deck1)
        player2 = Player.new("Aurora", deck2)
        
        turn = Turn.new(player1, player2)

        expect(turn.winner).to be_a Player
        expect(turn.winner).to eq(player2)
      end
    end

    describe 'a :mutually_assured_destruction turn type' do
      it "Will return 'No winner'" do
        card1 = Card.new(:heart, 'Jack', 11)
        card2 = Card.new(:heart, '10', 10)
        card3 = Card.new(:heart, '9', 9)
        card4 = Card.new(:diamond, 'Jack', 11)
        card5 = Card.new(:heart, '8', 8)
        card6 = Card.new(:diamond, '8', 8)
        card7 = Card.new(:heart, '3', 3)
        card8 = Card.new(:diamond, '2', 2)
  
        deck1 = Deck.new([card1, card2, card5, card8])
        deck2 = Deck.new([card4, card3, card6, card7])
  
        player1 = Player.new("Megan", deck1)
        player2 = Player.new("Aurora", deck2)
  
        turn = Turn.new(player1, player2)

        expect(turn.winner).to eq 'No winner'
      end
    end
  end

  describe '#pile_of_cards' do
    describe 'a :basic turn type' do
      it 'each player puts the top card in the spoils pile' do
        card1 = Card.new(:diamond, 'Queen', 12)
        card2 = Card.new(:spade, '3', 3)
        card5 = Card.new(:heart, '8', 8)
        card8 = Card.new(:diamond, '2', 2)
        
        card4 = Card.new(:diamond, 'Jack', 11)
        card3 = Card.new(:heart, 'Ace', 14)
        card6 = Card.new(:diamond, 'Queen', 12)
        card7 = Card.new(:heart, '3', 3)

        deck1 = Deck.new([card1, card2, card5, card8])
        deck2 = Deck.new([card4, card3, card6, card7])

        player1 = Player.new("Megan", deck1)
        player2 = Player.new("Aurora", deck2)
    
        turn = Turn.new(player1, player2)

        expect(turn.spoils_of_war.length).to eq 0

        turn.pile_of_cards

        expect(turn.player1.deck.cards.length).to eq 3
        expect(turn.player2.deck.cards.length).to eq 3
        expect(turn.spoils_of_war.length).to eq 2
      end
    end

    describe 'a :war turn type' do
      it 'each player removes top 3 cards and send them to the spoils pile' do
        card1 = Card.new(:heart, 'Jack', 11)
        card2 = Card.new(:heart, '10', 10)
        card5 = Card.new(:heart, '8', 8)
        card8 = Card.new(:diamond, '2', 2)

        card4 = Card.new(:diamond, 'Jack', 11)
        card3 = Card.new(:heart, '9', 9)
        card6 = Card.new(:diamond, 'Queen', 12)
        card7 = Card.new(:heart, '3', 3)

        deck1 = Deck.new([card1, card2, card5, card8])
        deck2 = Deck.new([card4, card3, card6, card7])

        player1 = Player.new("Megan", deck1)
        player2 = Player.new("Aurora", deck2)
        
        turn = Turn.new(player1, player2)

        expect(turn.spoils_of_war.length).to eq 0

        turn.pile_of_cards

        expect(turn.player1.deck.cards.length).to eq 1
        expect(turn.player2.deck.cards.length).to eq 1
        expect(turn.spoils_of_war.length).to eq 6
      end
    end

    describe 'a :mutually_assured_destruction turn type' do
      it "each player removes top 3 cards from play, and not sent to the spoils pile" do
        card1 = Card.new(:heart, 'Jack', 11)
        card2 = Card.new(:heart, '10', 10)
        card3 = Card.new(:heart, '9', 9)
        card4 = Card.new(:diamond, 'Jack', 11)
        card5 = Card.new(:heart, '8', 8)
        card6 = Card.new(:diamond, '8', 8)
        card7 = Card.new(:heart, '3', 3)
        card8 = Card.new(:diamond, '2', 2)

        deck1 = Deck.new([card1, card2, card5, card8])
        deck2 = Deck.new([card4, card3, card6, card7])

        player1 = Player.new("Megan", deck1)
        player2 = Player.new("Aurora", deck2)

        turn = Turn.new(player1, player2)

        expect(turn.spoils_of_war.length).to eq 0

        turn.pile_of_cards

        expect(turn.player1.deck.cards.length).to eq 1
        expect(turn.player2.deck.cards.length).to eq 1
        expect(turn.spoils_of_war.length).to eq 0
      end
    end
  end

  describe '#award_spoils' do
    it 'will add @spoils_of_war array to the winner of the turn' do
      card1 = Card.new(:diamond, 'Queen', 12)
      card2 = Card.new(:spade, '3', 3)
      card5 = Card.new(:heart, '8', 8)
      card8 = Card.new(:diamond, '2', 2)
      
      card4 = Card.new(:diamond, 'Jack', 11)
      card3 = Card.new(:heart, 'Ace', 14)
      card6 = Card.new(:diamond, 'Queen', 12)
      card7 = Card.new(:heart, '3', 3)

      deck1 = Deck.new([card1, card2, card5, card8])
      deck2 = Deck.new([card4, card3, card6, card7])

      player1 = Player.new("Megan", deck1)
      player2 = Player.new("Aurora", deck2)
  
      turn = Turn.new(player1, player2)
      winner = turn.winner

      turn.pile_of_cards

      expect(turn.spoils_of_war.length).to eq 2
      expect(turn.winner).to eq(player2)
      expect(player1.deck.cards.length).to eq 3
      expect(player2.deck.cards.length).to eq 3

      turn.award_spoils(winner)

      expect(player1.deck.cards.length).to eq 5
      expect(player2.deck.cards.length).to eq 3
    end
  end

end
