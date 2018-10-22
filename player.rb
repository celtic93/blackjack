class Player
  attr_reader :name
  attr_accessor :bankroll, :cards

  def initialize(name)
    @name = name
    @bankroll = 100
    @cards = []   
  end

  def take_card(deck)
    @cards << deck.give_card
  end

  def discard
    @cards = []
  end
end
