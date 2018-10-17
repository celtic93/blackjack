class Gameplay
  def initialize
    @player = Player.new('resd')
    @dealer = Dealer.new
    @interface = Interface.new

    @interface.start_game_message
  end

  def start_game
    loop do
      round = Round.new(@player, @dealer, @interface, self)
      round.round_running
      @interface.one_more_time_message
      if @interface.last_choice == 2 || @player.bankroll.zero?
        @interface.good_bye(@player)
        exit
      end
    end
  end

  # def end_of_the_round
  #  @interface.one_more_time_message
  #
  #  if @interface.last_choice == 1
  #    start_game
  #  else
  #    @interface.good_bye(@player)
  #  end
  # end
end
