require_relative '../dice'
require_relative 'attack'
require_relative 'attack_logs'
require_relative 'ranged_attack'

class Weapon < Attack
  prepend AttackLogs
  attr_reader :damage_dice, :finesse, :name, :ranged

  Weapons = YAML.load(File.read('yaml/weapons.yaml'))

  def initialize character, key
    super character
    @name = "a #{key}"
    weapon = Weapons[key]
    @damage_dice = Dice.new weapon['damage']
    @finesse = weapon['finesse']
    @ranged = weapon['ranged']
    @range = weapon['range'] || 5
    extend RangedAttack if ranged
  end

  private

  def average_damage
    damage_dice.average target.current_hp, ability_bonus
  end

  def roll_damage
    super + ability_bonus
  end

  def ability_bonus
    finesse || ranged ? character.dex.bonus : character.str.bonus
  end
end
