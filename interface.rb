class Interface

  attr_accessor :name, :choice, :last_choice



  def start_game_message
    puts 'Как вас зовут?'
    @name = gets.to_s.strip.capitalize!

    raise 'Введите правильное имя' if @name.nil?

    puts "#{@name}, добро пожаловать в казино 'Три пера'. Пусть с вами прибудет сила бизонов!"
  rescue StandardError => e
    puts e
    retry
  end

  def start_round_message(round, player_cards, player, cards_sum)
    puts "Вы поставили 10 фишек. Осталось #{player.bankroll}"
    puts "Ваши карты #{round.show_cards(player_cards)} Очков #{cards_sum.sum}"
    puts 'Карты дилера Х Х'
  end

  def player_choice_input_message(index)
    puts 'Сделайте выбор'
    puts '1 - Пропустить ход'
    puts '2 - Добавить карту'
    puts '3 - Открыть карты'
    @choice = gets.to_i

    raise 'Вы уже пропускали ход' if @choice == 1 && index == 1
    raise 'Выбирайте внимательней' unless (1..3).cover?(@choice)
  rescue RuntimeError => e
    puts e
    retry
  end

  def dealer_hits_message
    puts 'Ход дилера'
    puts 'Дилер добирает карту. Дилеру больше нельзя брать карты в этом раунде'
    puts 'Карты дилера Х Х X'
  end

  def dealer_stands_message
    puts 'Ход дилера'
    puts 'Дилер решил не брать карту'
    puts 'Карты дилера Х Х'
  end

  def add_card_message(round, player_cards, cards_sum)
    puts 'Вы взяли одну карту. Вам больше нельзя брать карты в этом раунде'
    puts "Ваши карты #{round.show_cards(player_cards)} Очков #{cards_sum.sum}"
  end

  def comparison_message(round, player_cards, dealer_cards, player_cards_sum, dealer_cards_sum)
    puts 'ВСКРЫВАЕМСЯ'
    puts "Ваши карты #{round.show_cards(player_cards)} Очков #{player_cards_sum.sum}"
    puts "Карты дилера #{round.show_cards(dealer_cards)} #{dealer_cards_sum.sum}"
  end

  def you_won_message(player)
    puts "Вы выиграли. Ваш банкролл #{player.bankroll}"
  end

  def you_lost_message(player)
    puts "Вы проиграли. Ваш банкролл #{player.bankroll}"
  end

  def tie_message(player)
    puts "Ничья, ставки возвращены. Ваш банкролл #{player.bankroll}"
  end

  def one_more_time_message
    puts 'Хотите сыграть еще?'
    puts '1 - Да, 2 - Нет'
    @last_choice = gets.to_i

    raise 'Выбирайте внимательней' unless (1..2).cover?(@last_choice)
  rescue RuntimeError => e
    puts e
    retry
  end

  def good_bye(player)
    puts "Мы рады, что вы #{@name} посетили казино 'Три пера'"

    if player.bankroll > 100
      puts 'Вы выиграли сегодня немного монет, с чем мы Вас поздравляем'
    elsif player.bankroll < 100
      puts 'К сожалению, удача была сегодня не на вашей стороне.'
      puts 'Но не расстраивайтесь, в следующий раз Вам обязательно повезет'
    else
      puts 'Вы остались при своих, а это тоже победа'
    end

    exit
  end
end
