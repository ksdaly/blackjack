#!/usr/bin/env ruby
# encoding: UTF-8
require 'pry'

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

def calculate_value(cards)
  value_array = cards.map { |card| card.chop }
  face_cards = ['J', 'Q', 'K']
  total = 0
  value_array.each do |value|
    if value == 'A'
        if total > 10
          total +=1
        else
          total +=11
        end
    elsif face_cards.include?(value)
      total +=10
    else
      total += value.to_i
    end
  end
  return total
end


deck = build_deck

player_cards = []
dealer_cards = []

2.times do
  player_cards << deck.pop
  dealer_cards << deck.pop
end

player_cards <<'A♠'
puts player_cards.inspect
puts dealer_cards.inspect



player_total = calculate_value(player_cards)
dealer_total = calculate_value(dealer_cards)

puts "Player was dealt: #{player_cards[0]}"
puts "Player was dealt: #{player_cards[1]}"
puts "Player's total is: #{player_total}"


puts "Sealer was dealt: #{dealer_cards[0]}"
puts "Dealer was dealt: #{dealer_cards[1]}"
puts "Dealer's total is: #{dealer_total}"

while player_total < 21
  puts "[H]it or [S]tay?"
  next_turn = gets.chomp
  if next_turn == "H"
    new_card = deck.pop
    puts "Player was dealt: #{new_card}"
    player_cards << new_card
    player_total = calculate_value(player_cards)
    puts "Player's total is: #{player_total}"
    puts "Player Busts" if player_total > 21
  end
end






# Takes the next card from the top of the deck.

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
