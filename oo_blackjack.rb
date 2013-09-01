#!/usr/bin/env ruby
require 'pry'

class Deck
  attr_accessor :cards
  SUITS = ['♠', '♣', '♥', '♦']
  VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

  def initialize
    @cards = []
    build_deck
  end

  def build_deck
    SUITS.each do |suit|
      VALUES.each do |value|
        @cards.push(Card.new(value, suit))
      end
    end
  end

  def next_card
    @cards.pop
  end

  def shuffle
    @cards.shuffle!
  end
end


class Card
  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def numeric_value
    if ['J', 'Q', 'K'].include?(@value)
      10
    elsif ['A'].include?(@value)
      1
    else
      @value.to_i
    end
  end

  def value
    @value
  end

  def suit
    @suit
  end

  # def display_card
  #   puts card.value + card.suit
  # end
end

class Hand
  attr_reader :cards
  def initialize(name)
    @name = name
    @cards = []
  end

  def hit(card)
    @cards << card
  end

  def stay
  end

  def score
    @cards.map(&:numeric_value)
    score = 0
    @cards.each do |card|
      score += card.numeric_value
    end
    if @cards.map(&:numeric_value).include?(1) && score + 10 <= 21
      score + 10
    else
      score
    end
  end

  def busted?(score)
    if score > 21
      puts "Busted"
      exit
    else
      return false
    end
  end
end

class Game
  def initialize
    @deck = Deck.new
  end

  def deal_hand
    @deck.shuffle
    @player_hand = Hand.new('player')
    @dealer_hand = Hand.new('dealer')
    @player_hand.hit(@deck.next_card)
    show_hand(@player_hand)
    @player_hand.hit(@deck.next_card)
    show_hand(@player_hand)

    puts "Player score: #{@player_hand.score}"
  end

  def show_hand(name_hand)
    card = name_hand.cards.last
    puts card.value + card.suit
  end

  def play_choice
    while true
      print "Hit or stand (H/S): "
      play = gets.chomp
      puts

      if play.upcase == 'H'
        @player_hand.hit(@deck.next_card)
        show_hand(@player_hand)
        puts "Player score: #{@player_hand.score}"
      elsif play.upcase == 'S'
        break
      end
      @player_hand.busted?(@player_hand.score) == false
    end
  end

  def play_as_dealer
    @dealer_hand.hit(@deck.next_card)
    show_hand(@dealer_hand)
    @dealer_hand.hit(@deck.next_card)
    show_hand(@dealer_hand)
    puts "Dealer's score: #{@dealer_hand.score}"
    puts
    while @dealer_hand.score < 17
      @dealer_hand.hit(@deck.next_card)
      show_hand(@dealer_hand)
      puts "Dealer's score: #{@dealer_hand.score}"
      @dealer_hand.busted?(@dealer_hand.score) == false
    end
  end

  def determine_winner
    if @player_hand.score == @dealer_hand.score
      puts "It's a tie... Just kidding, dealer always wins"
    elsif @player_hand.score > @dealer_hand.score
      puts "Player wins"
    elsif @player_hand.score < @dealer_hand.score
      puts "Dealer wins"
    end
  end
end


game = Game.new
game.deal_hand
game.play_choice
game.play_as_dealer
game.determine_winner