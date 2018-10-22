class Hand
  attr_accessor :deck

  def initialize
    @deck = Deck.new
  end

  def card_score(cards)
    points = cards.map(&:points).sum
    aces_num = cards.select { |card| card.points == 11 }.size
    aces_num.times do
      points -= 10 if points > 21
    end
    points
  end
end