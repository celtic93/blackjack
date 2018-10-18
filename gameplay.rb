class Gameplay
  def initialize
    @interface = Interface.new
    @interface.start_game_message

    @player = Player.new(@interface.name)
    @dealer = Dealer.new    
  end

  def start_game
    loop do
      round = Round.new(@player, @dealer, @interface)
      round.round_running
      end_game if @player.bankroll.zero?

      @interface.one_more_time_message

      end_game if @interface.last_choice == 2
    end
  end

  protected

  def end_game
    @interface.good_bye(@player)
    exit
  end
end
