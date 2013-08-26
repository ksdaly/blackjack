#!/usr/bin/env ruby
require 'pry'

class Deck
  attr_accessor :deck

  def initialize
    @deck = []
    build_deck
    @deck.shuffle!
  end

  def build_deck
    SUITS.each do |suit|
      VALUES.each do |value|
        @deck.push(value + suit)
      end
    end
  end

  def pop
    @deck.pop
  end
end


class Card
  def initialize(deck)
    @card = deck.pop
  end

  def card_value
    @card.chop
  end
end

class Hand
  def initialize

  end

  def hit(card)
  end

  def stay
  end

  def score
  end

  def busted?
  end
end



SUITS = ['♠', '♣', '♥', '♦']
VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

puts original_deck = Deck.new
puts original_deck.inspect
puts next_card = Card.new(original_deck)
puts next_card.card_value

puts original_deck.inspect

