class Interface
  def initialize
    start_game
  end

  def start_game
    begin
      puts 'Как вас зовут?'
      name = gets.to_s.strip.capitalize!

      raise 'Введите правильное имя' if name.nil?
    rescue StandardError => e
      puts e
      sleep 1
      retry
    end

    @player = Player.new(name)
    @dealer = Dealer.new
    @deck = Deck.new
    sleep 1
    puts "#{name}, добро пожаловать в казино 'Три пера'. Пусть с вами прибудет сила бизонов!"
    sleep 1
    get_cards_game
  end

  def get_cards_game
    @player.bets
    @dealer.bets
    puts "Вы поставили 10 фишек. Осталось #{@player.bankroll}"
    sleep 1

    2.times { @player.hits(@deck) }
    2.times { @dealer.hits(@deck) }
    @player.check_cards_sum
    @dealer.check_cards_sum

    puts "Ваши карты #{@player.show_cards} Очков #{@player.cards_sum}"
    sleep 1
    puts 'Карты дилера Х Х'
    sleep 1
    player_choice_input
  end

  def player_choice_input
    comparison if @player.cards.size > 2

    puts 'Сделайте выбор'
    puts '1 - Пропустить ход'
    puts '2 - Добавить карту'
    puts '3 - Открыть карты'
    @choice = gets.to_i

    raise 'Вы уже пропускали ход' if @choice == 1 && @dealer_choice_index == 1
    raise 'Выбирайте внимательней' unless (1..3).cover?(@choice)

    sleep 1
    player_choice
  rescue RuntimeError => e
    puts e
    sleep 1
    retry
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
      sleep 1
      comparison
    end

    @dealer_choice_index ||= 1

    puts 'Ход дилера'
    sleep 1

    if @dealer.cards_sum < 17
      @dealer.hits(@deck)
      @dealer.check_cards_sum
      puts 'Дилер добирает карту'
      sleep 1
      puts 'Карты дилера Х Х X'
      sleep 1
      puts 'Дилеру больше нельзя брать карты'
    else
      puts 'Дилер решил не брать карту'
      sleep 1
      puts 'Карты дилера Х Х'
    end

    sleep 1
    player_choice_input
  end

  def add_card
    puts 'Вы взяли одну карту'
    sleep 1

    @player.hits(@deck)
    @player.check_cards_sum
    puts "Ваши карты #{@player.show_cards} Очков #{@player.cards_sum}"
    sleep 1
    if @player.cards_sum > 21
      @dealer.wins_bank
      puts "Вы проиграли. Ваш банкролл #{@player.bankroll}"
      one_more_time?
    end
    puts 'Вам больше нельзя брать карты'
    sleep 1
    dealer_choice
  end

  def comparison
    puts 'ВСКРЫВАЕМСЯ'
    sleep 1
    puts "Ваши карты #{@player.show_cards} Очков #{@player.cards_sum}"
    sleep 1
    puts "Карты дилера #{@dealer.show_cards} #{@dealer.cards_sum}"
    sleep 1

    if @dealer.cards_sum > 21 || @player.cards_sum > @dealer.cards_sum
      @player.wins_bank
      puts "Вы выиграли. Ваш банкролл #{@player.bankroll}"
      sleep 1
    elsif @player.cards_sum < @dealer.cards_sum
      @dealer.wins_bank
      puts "Вы проиграли. Ваш банкролл #{@player.bankroll}"
      sleep 1
    elsif @player.cards_sum == @dealer.cards_sum
      puts "Ничья, ставки возвращены. Ваш банкролл #{@player.bankroll}"
      sleep 1
    end

    @player.bankroll > 0 ? one_more_time? : good_bye
  end

  def one_more_time?
    @player.end_round
    @dealer.end_round
    @deck.shuffle
    @dealer_choice_index = nil

    puts 'Хотите сыграть еще?'
    sleep 1
    puts '1 - Да, 2 - Нет'
    choice = gets.to_i

    raise 'Выбирайте внимательней' unless (1..2).cover?(choice)

    if choice == 1
      get_cards_game
    else
      good_bye
    end
  rescue RuntimeError => e
    puts e
    sleep 1
    retry
  end

  def good_bye
    puts "Мы рады, что вы #{@player.name} посетили казино 'Три пера'"
    sleep 1

    if @player.bankroll > 100
      puts 'Вы выиграли сегодня немного монет, с чем мы Вас поздравляем'
    elsif @player.bankroll < 100
      puts 'К сожалению, удача была сегодня не на вашей стороне.'
      puts 'Но не расстраивайтесь, в следующий раз Вам обязательно повезет'
    else
      puts 'Вы остались при своих, а это тоже победа'
    end

    sleep 1
    exit
  end
end
