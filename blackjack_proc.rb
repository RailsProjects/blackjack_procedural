# Blackjack in Procedural-Style Ruby Code
# by Laurence Kauffman
# July 1, 2013

require 'pry'

dealer_total = 0
player_total = 0
play_again = 'y'
hit = 'y'
bust = 'n'

full_deck = 
[ 'HA', 'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8', 'H9', 'H10', 'HJ', 'HQ', 'HK',
  'DA', 'D2', 'D3', 'D4', 'D5', 'D6', 'D7', 'D8', 'D9', 'D10', 'DJ', 'DQ', 'DK',
  'CA', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9', 'D10', 'CJ', 'CQ', 'CK',
  'SA', 'S2', 'S3', 'S4', 'S5', 'S6', 'S7', 'S8', 'S9', 'S10', 'SJ', 'SQ', 'SK' ]

def calculate_hand (hand) 
  total = 0
  hand2 = hand.dup # duplicate array so this method doesn't mutate/empty the original

  while hand2.size != 0  # or do hand.each
    card = hand2.pop

    case card[1]
    when 'A'
      if total + 11 > 21
        total += 1
      else
        total += 11
      end
    when '1'
      total += 10
    when 'J'
      total += 10
    when 'Q'
      total += 10
    when 'K'
      total += 10
    else
      total += card[1].to_i
    end
  end
  total
end

def display_hands(dealer_cards, player_cards)
    puts "Dealer's Up Card is: " + dealer_cards[0].to_s
    puts "Your Cards are:    " + player_cards.to_s  
    puts "Your Total is: " + calculate_hand(player_cards).to_s
end

print "Enter Your Name: "
player_name = gets.chomp
puts "Hello, " + player_name + ", Welcome to Blackjack!"
puts

# Play game
while play_again == 'y'
  hit = 'y'
  bust = 'n'
  deck = full_deck.shuffle
  dealer_cards = [deck.pop, deck.pop]
  player_cards = [deck.pop, deck.pop]

  # define method display_hands here to avoid runtime error:
  # `display_hands': undefined local variable or method `dealer_cards'
  
  # Ask if player wants a hit, check for bust
  while hit == 'y' && bust == 'n'
    display_hands(dealer_cards, player_cards)
    print "Do you want a hit? (y/n) "
    hit = gets.chomp
    puts

    if hit == 'y'
      player_cards << deck.pop
    end

    if player_total > 21
      bust = 'y'
    end
  end

  # If you bust then end game, else continue
  if bust == 'y'
    puts "You Bust."
  else
    # Dealer gets cards until s/he hits hard 17
    while dealer_total < 17 # less than hard 17
      dealer_cards << deck.pop
      dealer_total =  calculate_hand(dealer_cards) 
    end

    # List Dealer cards and total
    puts "Dealer Cards are: " + dealer_cards.to_s
    puts "Dealer Total is: " + dealer_total.to_s

    # Calculate outcome of game
    if dealer_total > 21 
      puts "Dealer busts.  YOU WIN!"
    elsif dealer_total < player_total 
      puts "YOU WIN!"  
    elsif dealer_total == player_total
      puts "It's a Push."    
    elsif dealer_total > player_total
      puts "You lose."
    end 
  end

  puts 'Play Again? (y/n)'
  play_again = gets.chomp
end    