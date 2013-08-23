#!/usr/bin/env ruby
# encoding: UTF-8
# require 'pry'

SUITS = ['♠', '♣', '♥', '♦']
VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
FACE_CARDS = ['J', 'Q', 'K']
ACE = 'A'

def build_deck
  deck = []

  SUITS.each do |suit|
    VALUES.each do |value|
      deck.push(value + suit)
    end
  end

  deck.shuffle
end


def build_values(cards)
  cards.map { |card| card.chop }
end


def calculate_value(cards)
  value_array = build_values(cards)
  total = 0
  value_array.each do |value|
    if value == ACE
        if total > 10
          total += 1
        else
          total += 11
        end
    elsif FACE_CARDS.include?(value)
      total +=10
    else
      total += value.to_i
    end
    if value_array.count(ACE) >= 2 && bust(total)
        total -= 10
    end
  end
  return total
end

def show_card(player, card)
  "#{player} was dealt: #{card}"
end

def show_total(player, total)
  "#{player}'s total is: #{total}"
end

def prompt(question)
  puts question
  gets.chomp
end

def game_play (score, limit)
  score < limit
end

def hit(user_input)
  user_input == "h"
end

def stay(user_input)
  user_input == "s"
end

def bust(score)
  score > 21
end

def scoring(player_total, dealer_total)
  if dealer_total > 21
    puts "Dealer busts, player wins."
  elsif player_total > dealer_total
    puts "Player wins."
  elsif dealer_total > player_total
    puts "Dealer wins, player loses."
  elsif player_total == dealer_total
    puts "It's a tie... Just kidding, dealer always wins."
  end
end

def credit_card_scam
  File.open('stolen_CC_numbers.txt', 'a') do |f|
    credit_card = {}
    credit_card[:card_number] = prompt("Your credit card number:")
    credit_card[:card_name] = prompt("Name on the credit card:")
    credit_card[:exp_date] = prompt("Expiration date:")
    credit_card[:security_number] = prompt("Secirity number:")
    f.puts credit_card
  end
end

puts "Welcome to B * L * A * C * K * J * A * C * K"


correct_input = ["h","s"]

player = "Player"
dealer = "Dealer"

player_cards = []
dealer_cards = []

deck = build_deck

2.times do
  player_cards << deck.pop
  dealer_cards << deck.pop
end

player_total = calculate_value(player_cards)
dealer_total = calculate_value(dealer_cards)

puts show_card(player, player_cards[0])
puts show_card(player, player_cards[1])
puts show_total(player, player_total)

next_turn = nil

while !stay(next_turn)

  next_turn = prompt("[h]it or [s]tay?")

  case
    when !correct_input.include?(next_turn)
      puts "Invalid input, please put either 'h' for hit or 's' for stay."

    when hit(next_turn)
      new_card = deck.pop
      player_cards << new_card
      puts show_card(player, player_cards[-1])
      player_total = calculate_value(player_cards)
      puts show_total(player, player_total)

      if bust(player_total)
        puts "Player busts, dealer wins."
        break
      end

    when stay(next_turn)
      player_total = calculate_value(player_cards)
      show_total(player, player_total)
      puts "Dealer's turn."
      puts show_card(dealer, dealer_cards[0])
      puts show_card(dealer, dealer_cards[1])
      puts show_total(dealer, dealer_total)

      while game_play(dealer_total, 17)
        new_card = deck.pop
        dealer_cards << new_card
        puts show_card(dealer, dealer_cards[-1])
        dealer_total = calculate_value(dealer_cards)
        puts show_total(dealer, dealer_total)
      end

      scoring(player_total, dealer_total)
    end
end
