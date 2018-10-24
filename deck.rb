require_relative 'cards'

class Deck
  attr_reader :cards

  def initialize
    @cards = []
    make_deck
  end

  def give_card
    @cards.pop
  end

  protected

  def make_deck
    Cards::VALUES.each do |value|
      Cards::SUITS.each do |suit|
        @cards << Cards.new(value, suit)
      end
    end
    @cards.shuffle!
  end
end
