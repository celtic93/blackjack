class Player

  attr_reader :name
  attr_accessor :cards_sum, :bankroll, :cards

  def initialize(name)
    @name = name
    @bankroll = 100
  end
end
