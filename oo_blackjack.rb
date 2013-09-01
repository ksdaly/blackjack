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

  def next_card(count)
    card_output = []
    count.times do

      card_output << @cards.pop
    end
    card_output

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
end

class Hand
  attr_reader :cards
  def initialize(name)
    @name = name
    @cards = []
  end

  def hit(cards)
    cards.each do |card|
    @cards << card
  end
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
      puts "Busted!"
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

  def play_turn(name_hand, name)
    name_hand.hit(@deck.next_card(1))
    show_hand(name_hand, -1,  name)
    puts "#{name}'s score: #{name_hand.score}"
  end

  def deal_hand
    @deck.shuffle
    @player_hand = Hand.new('player')
    @dealer_hand = Hand.new('dealer')
    @player_hand.hit(@deck.next_card(2))
    @dealer_hand.hit(@deck.next_card(2))
    show_hand(@player_hand, 0..1, "Player")
    puts "Player score: #{@player_hand.score}"
  end

  def show_hand(name_hand, range, name)
    cards = name_hand.cards[range]
    if cards.is_a?(Array)
      cards.each do |card|
        puts "#{name} was dealt: #{card.value + card.suit}"
      end
    else
      puts "#{name} was dealt: #{cards.value + cards.suit}"
    end
  end

  def play_choice
    while true
      print "Hit or stand (H/S): "
      play = gets.chomp
      puts
      if play.upcase == 'H'
        play_turn(@player_hand, "Player")
      elsif play.upcase == 'S'
        break
      end
      @player_hand.busted?(@player_hand.score) == false
    end
  end

  def play_as_dealer
    show_hand(@dealer_hand, 0..1,  "Dealer")
    puts "Dealer's score: #{@dealer_hand.score}"
    puts
    while @dealer_hand.score < 17
      play_turn(@dealer_hand, "Dealer")
      @dealer_hand.busted?(@dealer_hand.score) == false
    end
  end

  def play_turn(name_hand, name)
    name_hand.hit(@deck.next_card)
    show_hand(name_hand)
    puts "#{name}'s score: #{name_hand.score}"
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
