class Dealer
  include Game

  def initialize
    @bankroll = 100
    @cards = []
    @cards_sum = 0
  end

  def show_cards
    # Показывает карты в конце
  end
end