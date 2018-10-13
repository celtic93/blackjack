class Player
  include Game

  attr_reader :name
  attr_accessor :cards_sum, :bankroll, :cards

  def initialize(name)
    @name = name
    @bankroll = 100
    @cards = []
    @cards_sum = 0
  end
end
