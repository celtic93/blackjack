require_relative 'cards'

class Deck
  attr_reader :deck

  def initialize
    @deck = []
    make_deck
  end

  def give_card
    @deck.pop
  end

  protected

  def make_deck
    Card::VALUES.each do |value|
      Card::SUITS.each do |suit|
        @deck << Card.new(value, suit)
      end
    end
    @deck.shuffle!
  end
end
