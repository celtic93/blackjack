class Player
  include Game

  def initialize(name)
    @name = name
    @bankroll = 100
    @cards = []
    @cards_sum = 0
  end
end
