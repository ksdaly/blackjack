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
end

class Hand
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
puts original_deck.pop
puts original_deck.inspect

