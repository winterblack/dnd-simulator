require_relative '../player_character'
require_relative 'second_wind'

class Fighter < PlayerCharacter
  attr_accessor :has_second_wind

  def initialize character
    super character
    train_second_wind
  end

  private

  def train_second_wind
    bonus_actions << SecondWind.new(self)
    @has_second_wind = true
  end
end
