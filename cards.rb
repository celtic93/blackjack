class Card
  attr_reader :value, :suit, :points

  VALUES = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  SUITS = ['♠', '♣', '♦', '♥'].freeze

  def initialize(value, suit)
    @value = value
    @suit = suit
    @points = count_points
  end

  protected

  def count_points
    points = value.to_i if value.to_i
    points = 10 if %w[J Q K].include?(value)
    points = 11 if value == 'A'
    points
  end
end
