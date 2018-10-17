class Gameplay

  def initialize
    start_game
  end

  def start_game
    @player = Player.new('resd')
    @dealer = Dealer.new
    @interface = Interface.new

    @interface.start_game_message
    start_round
  end

  def start_round
    round = Round.new(@player, @dealer, @interface, self)
  end

  def end_of_the_round
    @interface.one_more_time_message

    if @interface.last_choice == 1
      start_round
    else
      @interface.good_bye(@player)
    end
  end
end
