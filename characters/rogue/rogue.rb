require_relative '../player_character'
require_relative 'sneak_attack'

class Rogue < PlayerCharacter
  def initialize character
    super character
    train_sneak_attack
  end

  private

  def train_sneak_attack
    weapon.extend SneakAttack if weapon.finesse || weapon.ranged
  end
end
