class Card
  attr_reader :value, :suit, :count

  def initialize(value, suit, count)
    @value = value
    @suit = suit
    @count = count
  end
end
