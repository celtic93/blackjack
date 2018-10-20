class Round

  def initialize(player, dealer, interface)
    @player = player
    @dealer = dealer
    @interface = interface
    @deck = Deck.new

    @player_cards = []
    @dealer_cards = []

    @player_cards_sum = 0
    @dealer_cards_sum = 0
  end

  def round_running
    betting
    deal_cards
    @interface.start_round_message(@player_cards, @player.bankroll, @player_cards_sum)
    first_choice = player_turn

    case first_choice
    when 1
      after_player_skipped
    when 2
      after_player_took_card
    when 3
      reveal_cards
      @interface.reveal_cards_message(@player.bankroll, @player_cards, @dealer_cards, @player_cards_sum, @dealer_cards_sum)
    end

    @interface.end_round_message
  end

  protected

  def after_player_skipped
    dealer_turn
    @interface.dealer_turn_message(@dealer_cards)     

    second_choice = player_turn
    add_card if second_choice == 2
    @interface.add_card_message(@player_cards, @player_cards_sum)

    lost_after_add_card

    if @player_cards_sum < 22
      reveal_cards
      @interface.reveal_cards_message(@player.bankroll, @player_cards, @dealer_cards, @player_cards_sum, @dealer_cards_sum)
    end
  end

  def after_player_took_card
    add_card
    @interface.add_card_message(@player_cards, @player_cards_sum)

    lost_after_add_card

    if @player_cards_sum < 22
      dealer_turn   
      @interface.dealer_turn_message(@dealer_cards)

      reveal_cards
      @interface.reveal_cards_message(@player.bankroll, @player_cards, @dealer_cards, @player_cards_sum, @dealer_cards_sum)     
    end
  end

  def betting
    bets(@player)
    bets(@dealer)
  end

  def deal_cards
    2.times { @player_cards_sum += hits(@deck, @player_cards) }
    2.times { @dealer_cards_sum += hits(@deck, @dealer_cards) }

    @player_cards_sum += check_cards_sum(@player_cards) if @player_cards_sum > 21
    @dealer_cards_sum += check_cards_sum(@dealer_cards) if @dealer_cards_sum > 21
  end

  def player_turn
    @interface.player_choice_message(@dealer_turn_index)
    @interface.choice
  end

  def dealer_turn
    @dealer_turn_index ||= 1

    if @dealer_cards_sum < 17
      @dealer_cards_sum += hits(@deck, @dealer_cards)
      @dealer_cards_sum += check_cards_sum(@dealer_cards) if @dealer_cards_sum > 21
    end
  end

  def add_card
    @player_cards_sum += hits(@deck, @player_cards)
    @player_cards_sum += check_cards_sum(@player_cards) if @player_cards_sum > 21
  end

  def lost_after_add_card
    if @player_cards_sum > 21
      wins_bank(@dealer)
      @interface.you_lost_message(@player.bankroll)
    end
  end

  def reveal_cards
    if @dealer_cards_sum > 21 || @player_cards_sum > @dealer_cards_sum
      wins_bank(@player)
    elsif @player_cards_sum < @dealer_cards_sum
      wins_bank(@dealer)
    elsif @player_cards_sum == @dealer_cards_sum
      return_bank(@player)
      return_bank(@dealer)
    end
  end

  def bets(player)
    player.bankroll -= 10
  end

  def hits(deck, cards)
    card = deck.give_card    
    cards << card
    card.count
  end

  def wins_bank(player)
    player.bankroll += 20
  end

  def return_bank(player)
    player.bankroll += 10
  end

  def check_cards_sum(cards)
    cards.select { |card| card.count == 11 }.any? ? cards_sum_bonus = -10 : cards_sum_bonus = 0  
  end
end
