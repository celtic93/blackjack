class Round
  def initialize(player, dealer, interface)
    @player = player
    @dealer = dealer
    @interface = interface
    @deck = Deck.new

    @player_cards = []
    @dealer_cards = []

    @player_points = 0
    @dealer_points = 0
  end

  def round_running
    betting
    initial_deal_cards
    @interface.start_round_message(@player_cards, @player.bankroll, @player_points)

    first_player_turn

    return end_round if @finished

    dealer_turn
    @interface.dealer_turn_message(@dealer_cards)

    return end_round if @finished

    second_player_turn if @player_cards.size < 3
    end_round
  end

  protected

  def betting
    @player.bankroll -= 10
    @dealer.bankroll -= 10
  end

  def initial_deal_cards
    2.times do
      @player_cards << @deck.give_card
      @dealer_cards << @deck.give_card
    end

    @player_points = card_score(@player_cards)
    @dealer_points = card_score(@dealer_cards)
  end

  def first_player_turn
    @choice = @interface.player_choice_message

    case @choice
    when 2
      add_card
      @interface.add_card_message(@player_cards, @player_points)
      @finished = true if @player_points > 21
    when 3
      @finished = true
    end
  end

  def dealer_turn
    return if @dealer_points >= 17

    @dealer_cards << @deck.give_card
    @dealer_points = card_score(@dealer_cards)

    @finished = true if @dealer_points > 21
  end

  def second_player_turn
    @choice = @interface.player_choice_message

    if @choice == 2
      add_card
      @interface.add_card_message(@player_cards, @player_points)
    end
  end

  def end_round
    calculate_winner
    reveal_bank

    @interface.end_round_message(@player.bankroll,
                                 @player_cards,
                                 @dealer_cards,
                                 @player_points,
                                 @dealer_points,
                                 @winner)
  end

  def calculate_winner
    return @winner = :player if @dealer_points > 21
    return @winner = :dealer if @player_points > 21
    return @winner = :draw if @player_points == @dealer_points

    @winner = @player_points - @dealer_points > 0 ? :player : :dealer
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

  def add_card
    @player_cards << @deck.give_card
    @player_points = card_score(@player_cards)
  end

  def card_score(cards)
    points = cards.map(&:count).sum
    aces_num = cards.select { |card| card.count == 11 }.size
    aces_num.times do
      points -= 10 if points > 21
    end
    points
  end
end
