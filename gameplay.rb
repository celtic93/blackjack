class Gameplay
  include Interface

  def initialize
    start_game
  end

  def start_game
    start_game_message

    @player = Player.new(@name)
    @dealer = Dealer.new
    @deck = Deck.new
           
    get_cards_game
  end

  def get_cards_game
    @player.bets
    @dealer.bets
        
    2.times { @player.hits(@deck) }
    2.times { @dealer.hits(@deck) }
    @player.check_cards_sum
    @dealer.check_cards_sum

    get_cards_game_message
    
    player_choice_input
  end

  def player_choice_input
    comparison if @player.cards.size > 2

    player_choice_input_message

    player_choice
  end

  def player_choice
    case @choice
    when 1
      dealer_choice
    when 2
      add_card
    when 3
      comparison
    end
  end

  def dealer_choice
    if @dealer_choice_index == 1     
      comparison
    end

    @dealer_choice_index ||= 1    

    if @dealer.cards_sum < 17
      @dealer.hits(@deck)
      @dealer.check_cards_sum

      dealer_hits_message
    else
      dealer_stands_message
    end
   
    player_choice_input
  end

  def add_card    
    @player.hits(@deck)
    @player.check_cards_sum

    add_card_message
    
    if @player.cards_sum > 21
      @dealer.wins_bank

      you_lost_message
      one_more_time?
    end   
    dealer_choice
  end

  def comparison
    comparison_message
    
    if @dealer.cards_sum > 21 || @player.cards_sum > @dealer.cards_sum
      @player.wins_bank

      you_won_message    
    elsif @player.cards_sum < @dealer.cards_sum
      @dealer.wins_bank

      you_lost_message      
    elsif @player.cards_sum == @dealer.cards_sum
      @player.return
      @dealer.return

      tie_message     
    end

    @player.bankroll > 0 ? one_more_time? : good_bye
  end

  def one_more_time?
    @player.end_round
    @dealer.end_round
    @deck.shuffle
    @dealer_choice_index = nil

    one_more_time_message?

    if @last_choice == 1
      get_cards_game
    else
      good_bye
    end
  end
end
