class Player
  attr_reader :name
  attr_accessor :bankroll

  def initialize(name)
    @name = name
    @bankroll = 100
  end
end
