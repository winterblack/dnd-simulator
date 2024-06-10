require_relative '../actions/dash'
require_relative '../actions/move'
require_relative '../actions/weapon'
require_relative '../dice'
require_relative 'attribute'
require_relative 'positioning'

class Character
  include Positioning
  attr_accessor :foes
  attr_reader :str, :dex, :con, :int, :wis, :cha,
              :ac, :hp, :level, :name, :speed, :weapon,
              :current_hp, :dead, :has_reaction, :initiative, :position,
              :proficiency_bonus

  def initialize character
    @str = Attribute.new character['str']
    @dex = Attribute.new character['dex']
    @con = Attribute.new character['con']
    @int = Attribute.new character['int']
    @wis = Attribute.new character['wis']
    @cha = Attribute.new character['cha']
    @ac = character['ac']
    @hp = @current_hp = character['hp']
    @level = character['level'] || character['challenge'].to_i
    @proficiency_bonus = 2 + (level - 1) / 4
    @speed = character['speed']
    @weapon = Weapon.new self, character['weapon']
    @has_reaction = true
  end

  def take_turn
    start_turn
    choose_action.perform
  end

  def take damage
    @current_hp -= damage
    @dead = true if current_hp < 1
  end

  def roll_initiative
    @initiative = D20.roll + dex.bonus
  end

  private

  def start_turn
    @has_reaction = true
  end

  def living_foes
    foes.reject(&:dead)
  end

  def actions
    dash = Dash.new self
    move_attack = weapon.dup.extend Move
    [dash, move_attack, weapon]
  end

  def choose_action
    actions.select(&:valid?).max_by(&:evaluate)
  end

  def inspect
    "<#{name} ac:#{ac} hp:#{current_hp}/#{hp} position:#{position}>"
  end
end
