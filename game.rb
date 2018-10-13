module Game
  def get_cards(deck)
    card = deck.give_card
    @card_sum += card.count
    @cards << card
  end

  def bets
    @bankroll -= 10
  end

  def hits(deck)
    card = deck.give_card
    self.cards_sum += card.count
    cards << card
  end

  def wins_bank
    @bankroll += 20
  end

  def return
    @bankroll += 10
  end

  def show_cards
    cards.map { |card| card.value + card.suit }.join(' ')
  end

  def check_cards_sum
    @cards_sum -= 10 if @cards.select { |card| card.value == 'A' }.any? && @cards_sum > 21
  end

  def end_round
    @cards = []
    @cards_sum = 0
  end
end
