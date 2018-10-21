class Gameplay
  def initialize
    @interface = Interface.new
    name = @interface.ask_name
    @interface.greeting(name)

    @player = Player.new(name)
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
    @interface.good_bye(@player.bankroll)
    exit
  end
end
