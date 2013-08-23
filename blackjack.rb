#!/usr/bin/env ruby
# encoding: UTF-8
require 'pry'

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
  end
  if value_array.count(ACE) >= 1 && bust(total)
    total -= 10
  end

  return total
end

def show_card(player, cards)
  cards.each do |card|
    puts "#{player} was dealt: #{card}"
  end
end

def show_total(player, total)
  puts "#{player}'s total is: #{total}"
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

def say_hello
  "Welcome to B * L * A * C * K * J * A * C * K"
end

def deal_cards(user_hands, cards)
  cards.times do
    user_hands.each do |hand|
      hand << @deck.pop
    end
  end
end

def play_turn(user, user_hands)
  deal_cards([user_hands], 1)
  show_card(user, [user_hands[-1]])
  total = calculate_value(user_hands)
  show_total(user, total)
  total
end


puts say_hello


@correct_input = ["h","s"]

player = "Player"
dealer = "Dealer"

@player_cards = []
@dealer_cards = []

@deck = build_deck

# credit_card_scam

deal_cards([@player_cards, @dealer_cards], 2)

@player_total = calculate_value(@player_cards)
@dealer_total = calculate_value(@dealer_cards)

show_card(player, @player_cards)
show_total(player, @player_total)


next_turn = nil

while !stay(next_turn)
  next_turn = prompt("[h]it or [s]tay?")

  case
    when !@correct_input.include?(next_turn)
      puts "Invalid input, please put either 'h' for hit or 's' for stay."

    when hit(next_turn)

      @player_total = play_turn(player, @player_cards)

      if bust(@player_total)
        puts "Player busts, dealer wins."
        break
      end

    when stay(next_turn)
      show_total(player, @player_total)
      puts "Dealer's turn."
      show_card(dealer, @dealer_cards)
      show_total(dealer, @dealer_total)

      while game_play(@dealer_total, 17)
        @dealer_total = play_turn(dealer, @dealer_cards)
      end

      scoring(@player_total, @dealer_total)
  end
end
