require_relative '../../dice'

module SneakAttack
  private

  def sneaking?
    return false if advantage_disadvantage == :disadvantage

    advantage_disadvantage == :advantage || target.close_combat?
  end

  def dice_count
    sneaking? ? (character.level + 1) / 2 : 0
  end

  def sneak_attack_dice
    Dice.new "#{dice_count}d6"
  end

  def damage_dice
    MixedDice.new([@damage_dice, sneak_attack_dice])
  end
end
