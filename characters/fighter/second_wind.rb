require_relative '../../actions/bonus_action'
require_relative '../../logs'

class SecondWind < BonusAction
  include Logs

  def perform
    log "#{character.name} uses Second Wind"
    character.heal roll_healing
    character.has_second_wind = false
  end

  def evaluate
    @value = average_healing / character.hp
  end

  def valid?
    true
  end

  private

  def roll_healing
    healing_dice.roll + bonus
  end

  def average_healing
    healing_dice.average(character.hp - character.current_hp, bonus)
  end

  def healing_dice
    Dice.new '1d10'
  end

  def bonus
    character.level
  end
end
