require_relative 'cards'
require_relative 'interface'
require_relative 'deck'
require_relative 'round'
require_relative 'player'
require_relative 'dealer'
require_relative 'gameplay'
require_relative 'hand'

gameplay = Gameplay.new
gameplay.start_game
