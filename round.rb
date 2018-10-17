class Round

  #attr_accessor :player_cards, :dealer_cards, :player_cards_sum, :dealer_cards_sum

  def initialize(player, dealer, interface, gameplay)
    @player = player
    @dealer = dealer
    @interface = interface
    @gameplay = gameplay
    @deck = Deck.new

    @player_cards = []
    @dealer_cards = []

    @player_cards_sum = []
    @dealer_cards_sum = []

    get_cards
  end

  def show_cards(cards)
    cards.map { |card| card.value + card.suit }.join(' ')
  end

  protected

  def get_cards
    bets(@player)
    bets(@dealer)

    2.times { hits(@deck, @player_cards, @player_cards_sum) }
    2.times { hits(@deck, @dealer_cards, @dealer_cards_sum) }

    check_cards_sum(@player_cards_sum)
    check_cards_sum(@dealer_cards_sum)

    @interface.start_round_message(self, @player_cards ,@player, @player_cards_sum)

    player_choice_input
  end

  def player_choice_input
    comparison if @player_cards.size > 2

    @interface.player_choice_input_message(@dealer_choice_index)

    player_choice
  end

  def player_choice
    case @interface.choice
    when 1
      dealer_choice
    when 2
      add_card
    when 3
      comparison
    end
  end

  def dealer_choice
    comparison if @dealer_choice_index == 1

    @dealer_choice_index ||= 1

    if @dealer_cards_sum.sum < 17
      hits(@deck, @dealer_cards, @dealer_cards_sum)
      check_cards_sum(@dealer_cards_sum)

      @interface.dealer_hits_message
    else
      @interface.dealer_stands_message
    end

    player_choice_input
  end

  def add_card
    hits(@deck, @player_cards, @player_cards_sum)
    check_cards_sum(@player_cards_sum)

    @interface.add_card_message(self, @player_cards, @player_cards_sum)

    if @player_cards_sum.sum > 21
      wins_bank(@dealer)

      @interface.you_lost_message(@player)
      @gameplay.end_of_the_round
    end
    dealer_choice
  end

  def comparison
    @interface.comparison_message(self, @player_cards, @dealer_cards, @player_cards_sum, @dealer_cards_sum)

    if @dealer_cards_sum.sum > 21 || @player_cards_sum.sum > @dealer_cards_sum.sum
      wins_bank(@player)

      @interface.you_won_message(@player)
    elsif @player_cards_sum.sum < @dealer_cards_sum.sum
      wins_bank(@dealer)

      @interface.you_lost_message(@player)
    elsif @player_cards_sum.sum == @dealer_cards_sum.sum
      return_bank(@player)
      return_bank(@dealer)

      @interface.tie_message(@player)
    end

    @player.bankroll > 0 ? @gameplay.end_of_the_round : @interface.good_bye(@player)
  end

  def bets(player)
    player.bankroll -= 10
  end

  def hits(deck, cards, cards_sum)
    card = deck.give_card
    cards_sum << card.count
    cards << card
  end

  def wins_bank(player)
    player.bankroll += 20
  end

  def return_bank(player)
    player.bankroll += 10
  end

  def check_cards_sum(cards_sum)
    cards_sum << -10 if cards_sum.select { |card| card == 11 }.any? && cards_sum.sum > 21
  end

  def end_round(cards, cards_sum)
    cards = []
    cards_sum = 0
  end
end
