class Dealer
  attr_accessor :bankroll

  def initialize
    @bankroll = 100
  end

  def cards
    @hand.cards    
  end

  def points
    @hand.points
  end

  def take_card
    @hand.add_card
  end

  def new_hand(deck)
    @hand = Hand.new(deck)
  end
end
