require_relative '../dice'
require_relative 'action'

class Attack < Action
  def perform
    super
    attack target unless character.dead
  end

  def attack target
    @target = target
    roll_to_hit ? hit : miss
  end

  def evaluate_target target
    @target = target
    hit_chance * evaluate_damage
  end

  private

  def advantage_disadvantage
  end

  def average_damage
    damage_dice.average target.current_hp
  end

  def evaluate_damage
    average_damage / target.current_hp
  end

  def hit_chance
    chance = (21 - target.ac + to_hit_bonus) / 20.0
    return chance**2 if advantage_disadvantage == :disadvantage
    return 1 - (1 - chance)**2 if advantage_disadvantage == :advantage

    chance
  end

  def damage_dice
    # implement in attack
  end

  def miss
    # implemented in AttackLogs
  end

  def roll_damage
    damage_dice.roll
  end

  def hit
    target.take roll_damage
  end

  def ability_bonus
    # implement in attack
  end

  def to_hit_bonus
    character.proficiency_bonus + ability_bonus
  end

  def attack_roll
    D20.roll(advantage_disadvantage) + to_hit_bonus
  end

  def roll_to_hit
    attack_roll >= target.ac
  end
end
