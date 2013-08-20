#!/usr/bin/env ruby
# encoding: UTF-8

SUITS = ['♠', '♣', '♥', '♦']
VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

def build_deck
  deck = []

  SUITS.each do |suit|
    VALUES.each do |value|
      deck.push(value + suit)
    end
  end

  deck.shuffle
end

deck = build_deck
# Takes the next card from the top of the deck.
next_card = deck.pop

puts next_card

# Shuffle deck of cards

# Player is dealt a card (x2)

# Prompt player to hit or stand until they stand or bust

# Display player's score after they hit or stand

  # If input is invalid (neither hit or stand) notify and reprompt

  # If player hits deal another card

    # Display player's recalculated score

      # If player busts then exit game

  # If player stands

    # Display player's recalculated score

    # End players turn and switch to dealer

      # Dealer is dealt 2 cards

      # If dealer score is less than 17

        # Continue hitting until score over 17

      # If dealer score is greater than 21

        # Dealer loses

# If score equals 21, they win

# If score less than 21, player with the higher score wins
