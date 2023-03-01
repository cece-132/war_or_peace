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
      @player2 = Player.new("Computer King")
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
      war_peace_destruction
    elsif input.downcase == 'q'
      puts "Sorry you don't wanna play, see you next time."
    else
      puts "Incorrect input. Type 'p' to play or 'q' to quit"
    end
  end

  def war_peace_destruction
    loop do
      turn = Turn.new(@player1, @player2)
      type = turn.type
      turn.pile_of_cards
      winner = turn.winner
      turn.pile_of_cards
      turn.award_spoils(winner)
      break if game_over? == true

      if type == :basic
        puts "Turn#{@turn_count}: #{turn.winner.name.capitalize} won 2 cards"
      elsif type == :mutually_assured_destruction
        puts "Turn#{@turn_count}: *#{turn.type.to_s.gsub('_', ' ')}* 6 cards"
      elsif type == :war
        puts "Turn#{@turn_count}: #{turn.type.to_s.upcase} won 6 cards"
      end
      @turn_count += 1
    end

    if @player1.has_lost?
      return puts "*~*~*~* #{@player2.name} Won *~*~*~*"
    elsif @player2.has_lost?
      return puts "*~*~*~* #{@player1.name} Won *~*~*~*"
    else
      return puts "DRAW GAME OVER"
    end
  end

  def game_over?
    turn_count > 999999 || @player1.has_lost? || @player2.has_lost?
  end

end