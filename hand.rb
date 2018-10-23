class Hand
  attr_accessor :points, :cards

  def initialize
    @points = 0
    @cards = []
  end

  def card_score(cards)
    points = cards.map(&:points).sum
    aces_num = cards.select { |card| card.points == 11 }.size
    aces_num.times do
      points -= 10 if points > 21
    end
    points
  end

  def add_card(deck)
    @cards << deck.give_card
    @points = card_score(cards)
  end

  def deck; end
end
