#!/usr/bin/env ruby
# encoding: UTF-8
# require 'pry'

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

def show_card(player, card)
  puts "#{player} was dealt: #{card}"
end

def show_total(player, total)
  puts "#{player}'s total is: #{total}"
end

def prompt(question)
  puts question
  gets.chomp
end

player = "Player"
dealer = "Dealer"

player_cards = []
dealer_cards = []

deck = build_deck

# Takes the next card from the top of the deck.
2.times do
  player_cards << deck.pop
  dealer_cards << deck.pop
end

# player_cards << 'A♠'
# puts player_cards.inspect
# puts dealer_cards.inspect

player_total = calculate_value(player_cards)
dealer_total = calculate_value(dealer_cards)

show_card(player, player_cards[0])
show_card(player, player_cards[1])
show_total(player, player_total)


if player_total == 21
  puts "you win" 
  exit
elsif player_total > 21
  puts "you lose"
end

correct_input = ["H","S"]
# Prompt player to hit or stand until they stand or bust

  next_turn = prompt("[H]it or [S]tay?")


def game_play (score, limit)
  score < limit
end

  # If input is invalid (neither hit or stand) notify and reprompt
    if !correct_input.include?(next_turn)    
      puts "Invalid input, please put either H for hit or S for stay."
    elsif next_turn == "H"
      while game_play(player_total, 21)
        # If player hits deal another card
        new_card = deck.pop
        player_cards << new_card
        show_card(player, player_cards[-1])
        player_total = calculate_value(player_cards)
        # Display player's score after they hit or stand
        show_total(player, player_total)
        puts "Player Busts" if player_total > 21
      end
    elsif next_turn == "S"
      # Display player's recalculated score
      show_total(player, player_total)
    end

show_card(dealer, dealer_cards[0])
show_card(dealer, dealer_cards[1])
show_total(dealer, dealer_total)

if dealer_total == 21
  puts "you win" 
  
elsif dealer_total > 21
  puts "you lose"
end

      while game_play(dealer_total, 17)
        # If player hits deal another card
        new_card = deck.pop
        dealer_cards << new_card
        show_card(dealer, dealer_cards[-1])
        dealer_total = calculate_value(dealer_cards)
        # Display player's score after they hit or stand
        show_total(dealer, dealer_total)
        puts "Dealer Busts" if dealer_total > 21
      end



if dealer_total == 21
  puts "Dealer wins"
elsif dealer_total > player_total
  puts "Dealer wins"
else
  puts "Player wins"
end



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
