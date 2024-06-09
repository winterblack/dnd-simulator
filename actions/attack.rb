require_relative '../dice'
require_relative 'action'

class Attack < Action
  def perform
    super
    attack target
  end

  def attack target
    @target = target
    roll_to_hit ? hit : miss
  end

  private

  def average_damage
    damage_dice.average
  end

  def evalaute_damage
    [average_damage / target.current_hp, 1].min
  end

  def hit_chance
    (21 - target.ac + to_hit_bonus) / 20.0
  end

  def evaluate_target target
    @target = target
    hit_chance * evalaute_damage
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
    D20.roll + to_hit_bonus
  end

  def roll_to_hit
    attack_roll >= target.ac
  end
end
