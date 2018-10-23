class Round

  def initialize(player, dealer, interface)
    @player = player
    @dealer = dealer
    @interface = interface

    deck = Deck.new
    @player.new_hand(deck)
    @dealer.new_hand(deck)
  end

  def round_running
    betting
    initial_deal_cards

    @interface.start_round_message(@player.cards, @player.bankroll, @player.points)

    first_player_turn
    return end_round if @finished

    dealer_turn
    @interface.dealer_turn_message(@dealer.cards)

    return end_round if @finished

    second_player_turn if @player.cards.size < 3
    end_round
  end

  protected

  def betting
    @player.bankroll -= 10
    @dealer.bankroll -= 10
  end

  def initial_deal_cards
    2.times do
      @player.take_card
      @dealer.take_card
    end
  end

  def first_player_turn
    @choice = @interface.player_choice_message

    case @choice
    when 2
      @player.take_card
      @interface.add_card_message(@player.cards, @player.points)
      @finished = true if @player.points > 21
    when 3
      @finished = true
    end
  end

  def dealer_turn
    return if @dealer.points >= 17

    @dealer.take_card

    @finished = true if @dealer.points > 21
  end

  def second_player_turn
    @choice = @interface.player_choice_message

    if @choice == 2
      @player.take_card
      @interface.add_card_message(@player.cards, @player.points)
    end
  end

  def end_round
    calculate_winner
    reveal_bank

    @interface.end_round_message(@player.bankroll,
                                 @player.cards,
                                 @dealer.cards,
                                 @player.points,
                                 @dealer.points,
                                 @winner)
  end

  def calculate_winner
    return @winner = :player if @dealer.points > 21
    return @winner = :dealer if @player.points > 21
    return @winner = :draw if @player.points == @dealer.points
    @winner = @player.points - @dealer.points > 0 ? :player : :dealer
  end

  def reveal_bank
    if @winner == :player
      @player.bankroll += 20
    elsif @winner == :dealer
      @dealer.bankroll += 20
    else
      @player.bankroll += 10
      @dealer.bankroll += 10
    end
  end
end
