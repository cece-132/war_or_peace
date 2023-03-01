require './lib/turn'
require './lib/dealer'
require 'pry'

class Play
  attr_reader :player1, :player2, :turn_count

  def initialize(player1 = nil, player2 = nil)
    @player1 = player1
    @player2 = player2
    @turn_count = 1
  end

  def welcome_message
    puts "Welcome to War! (or Peace) This game will be played with 52 cards.\n ------------------------------------------------------------------"
    puts "Are there 1 or 2 players? (Enter 1 or 2)"
    input = gets.chomp
    player_count(input)
    puts "The players today are #{@player1.name.upcase} and #{@player2.name.upcase}"
    puts "Type 'p' to play or 'q' to quit"
    puts "------------------------------------------------------------------"
    play_option = gets.chomp
    start(play_option)
  end

  def player_count(input)
    if input == "1"
      puts "Please type player ones name"
      @player2 = Player.new("A Computer Named King")
      @player1 = Player.new(gets.chomp)
    elsif input == "2"
      puts "Please type player ones name"
      @player1 = Player.new(gets.chomp)
      puts "Please type player twos name"
      @player2 = Player.new(gets.chomp)
    else
      puts "Incorrect input. Please enter eithe a 1 or a 2"
      welcome_message
    end
  end

  def start(input)
    if input.downcase == 'p'
      Dealer.new.deal(@player1, @player2).shuffle
      war
    elsif input.downcase == 'q'
      puts "Sorry you don't wanna play, see you next time."
    else
      puts "Incorrect input. Type 'p' to play or 'q' to quit"
    end
  end

  def war
    until game_over? do
      turn = Turn.new(player1, player2)
      type = turn.type
      turn.pile_of_cards
      winner = turn.winner
      turn.pile_of_cards
      turn.award_spoils(winner)

      if type == :basic
        puts "Turn#{@turn_count}: #{turn.winner.name.capitalize} won #{turn.award_spoils(turn.winner).count} cards"
      elsif type == :mutually_assured_destruction
        binding.pry
        puts "Turn#{@turn_count}: *#{turn.type.to_s.gsub('_', ' ')}*  #{turn.award_spoils(turn.winner)} cards"
      elsif type == :war
        puts "Turn#{@turn_count}: #{turn.type.to_s.upcase} won #{turn.award_spoils(turn.winner).count} card"
      end
      
      @turn_count += 1

      # if turn.type == :basic
      #   turn.pile_of_cards
      #   turn.award_spoils(turn.winner)
      #   puts "#{turn.winner.name.capitalize} won #{turn.award_spoils(turn.winner).count} cards"
      # elsif turn.type == :war
      #   turn.pile_of_cards
      #   turn.award_spoils(turn.winner)
      #   puts "#{turn.type.to_s.upcase} - won #{turn.award_spoils(turn.winner).count} cards"
      # elsif turn.type == :mutually_assured_destruction
      #   turn.pile_of_cards
      #   turn.award_spoils(turn.winner)
      #   puts "*#{turn.type.to_s.gsub('_', ' ')}* - #{turn.award_spoils(turn.winner)}"
      # end
    end

    if @player1.has_lost?
      puts "*~*~*~* #{@player2.name} Won *~*~*~*"
    elsif @player2.has_lost?
      puts "*~*~*~* #{@player1.name} Won *~*~*~*"
    end

  end

  def game_over?
    turn_count == 1_000_000 || @player1.has_lost? || @player2.has_lost?
  end

end