class Dealer
  attr_accessor :bankroll, :cards

  def initialize
    @bankroll = 100
    @cards = []
    @points = 0
  end

  def take_card(deck)
    @cards << deck.give_card
  end

  def discard
    @cards = []
  end
end
