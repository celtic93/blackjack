require_relative 'cards'

class Deck
  attr_reader :deck

  VALUES = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  SUITS = ['♠', '♣', '♦', '♥'].freeze

  def initialize
    @deck = []
    make_deck
  end

  def give_card
    @card = @deck.sample
    @deck.delete(@card)
    @card
  end

  protected

  def make_deck
    VALUES.each do |value|
      SUITS.each do |suit|
        count = value.to_i if value.to_i
        count = 10 if %w[J Q K].include?(value)
        count = 11 if value == 'A'
        @deck << Card.new(value, suit, count)
      end
    end
  end
end
