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

  def value
    if ['J', 'Q', 'K'].include?(@value)
      10
    elsif ['A'].include?(@value)
      1
    else
      @value.to_i
    end
  end

  def suit
    @suit
  end

end

class Hand
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
    puts @cards.map(&:value)
    score = 0
    @cards.each do |card|
      score += card.value
    end
    if @cards.map(&:value).include?(1) && score + 10 <= 21
      score +10
    else
      score
    end

  end

  def busted?
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
    @player_hand.hit(@deck.next_card)
    puts @player_hand.score
  end
end


game = Game.new
game.deal_hand

