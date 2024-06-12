require_relative '../actions/dash'
require_relative '../actions/move'
require_relative '../actions/weapon'
require_relative '../dice'
require_relative 'attribute'
require_relative 'character_logs'
require_relative 'positioning'

class Character
  include Positioning
  prepend CharacterLogs
  attr_accessor :foes
  attr_reader :str, :dex, :con, :int, :wis, :cha,
              :ac, :hp, :level, :name, :speed, :weapon,
              :actions, :bonus_actions, :current_hp, :dead, :has_bonus_action,
              :has_reaction, :initiative, :position, :proficiency_bonus

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
    @bonus_actions = []
    set_actions
  end

  def heal healing
    binding.pry if @healing == 0
    @current_hp += limit_healing healing
  end

  def take_turn
    start_turn
    choose_action.perform
    end_turn
  end

  def take damage
    @current_hp -= damage
    @dead = true if current_hp < 1
  end

  def roll_initiative
    @initiative = D20.roll + dex.bonus
  end

  private

  def limit_healing healing
    @healing = [hp - current_hp, healing].min
  end

  def choose_bonus_action
    bonus_actions.select(&:valid?).max_by(&:evaluate)
  end

  def maybe_perform_bonus_action
    bonus_action = choose_bonus_action if has_bonus_action
    if bonus_action && bonus_action.value > 0
      bonus_action.perform
      @has_bonus_action = false
    end
  end

  def end_turn
    maybe_perform_bonus_action
  end

  def start_turn
    @has_bonus_action = true
    @has_reaction = true
    maybe_perform_bonus_action
  end

  def living_foes
    foes.reject(&:dead)
  end

  def set_actions
    dash = Dash.new self
    move_attack = weapon.clone.extend Move
    @actions = [dash, move_attack, weapon]
  end

  def choose_action
    actions.select(&:valid?).max_by(&:evaluate)
  end

  def inspect
    "<#{name} ac:#{ac} hp:#{current_hp}/#{hp} position:#{position}>"
  end
end
