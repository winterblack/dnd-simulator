require 'pry'

module SneakAttack
  private

  def roll_sneak_attack_damage
    sneaking? ? sneak_attack_dice.roll : 0
  end

  def roll_damage
    @damage = super + roll_sneak_attack_damage
  end

  def sneak_attack_dice
    Dice.new "#{(character.level + 1) / 2}d6"
  end

  def sneaking?
    return false if advantage_disadvantage == :disadvantage

    advantage_disadvantage == :advantage || target.close_combat?
  end

  def average_sneak_attack_damage
    sneaking? ? sneak_attack_dice.average : 0
  end

  def average_damage
    super + average_sneak_attack_damage
  end
end
