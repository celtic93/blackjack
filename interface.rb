class Interface
  attr_accessor :choice, :last_choice

  def ask_name
    puts 'Как вас зовут?'
    name = gets.to_s.strip

    raise 'Введите правильное имя' if name.empty?

    name.capitalize
  rescue StandardError => e
    puts e
    retry
  end

  def greeting(name)
    puts "#{name}, добро пожаловать в казино 'Три пера'. Пусть с вами прибудет сила бизонов!"
  end

  def start_round_message(player_cards, bankroll, points)
    puts "Вы поставили 10 фишек. Осталось #{bankroll}"
    puts "Ваши карты #{show_cards(player_cards)} Очков #{points}"
    puts 'Карты дилера Х Х'
  end

  def player_choice_message
    puts 'Сделайте выбор'
    puts '1 - Пропустить ход'
    puts '2 - Добавить карту'
    puts '3 - Открыть карты'
    @choice = gets.to_i

    raise 'Выбирайте внимательней' unless (1..3).cover?(@choice)

    @choice
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

  def add_card_message(player_cards, points)
    puts 'Вы взяли одну карту. Вам больше нельзя брать карты в этом раунде'
    puts "Ваши карты #{show_cards(player_cards)} Очков #{points}"
  end

  def end_round_message(bankroll,
                        player_cards,
                        dealer_cards,
                        player_points,
                        dealer_points,
                        winner)
    puts 'ВСКРЫВАЕМСЯ'
    puts "Ваши карты #{show_cards(player_cards)} Очков #{player_points}"
    puts "Карты дилера #{show_cards(dealer_cards)} #{dealer_points}"

    if winner == :player
      puts "Вы выиграли. Ваш банкролл #{bankroll}"
    elsif winner == :dealer
      you_lost_message(bankroll)
    elsif winner == :draw
      puts "Ничья, ставки возвращены. Ваш банкролл #{bankroll}"
    end
    puts 'Раунд окончен'
  end

  def you_lost_message(bankroll)
    puts "Вы проиграли. Ваш банкролл #{bankroll}"
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

  def good_bye(bankroll)
    puts "Мы рады, что вы посетили казино 'Три пера'"

    if bankroll > 100
      puts 'Вы выиграли сегодня немного монет, с чем мы Вас поздравляем'
    elsif bankroll < 100
      puts 'К сожалению, удача была сегодня не на вашей стороне.'
      puts 'Но не расстраивайтесь, в следующий раз Вам обязательно повезет'
    else
      puts 'Вы остались при своих, а это тоже победа'
    end

    exit
  end

  def dealer_turn_message(dealer_cards)
    if dealer_cards.size == 3
      dealer_hits_message
    else
      dealer_stands_message
    end
  end

  protected

  def show_cards(cards)
    cards.map { |card| card.value + card.suit }.join(' ')
  end
end
