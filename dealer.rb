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

  def take_card(deck)
    @hand.add_card(deck)
  end

  def new_hand
    @hand = Hand.new
  end
end
