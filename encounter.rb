require 'yaml'
require_relative 'characters/character'
require_relative 'outcome'

class Encounter
  attr_reader :keys, :monsters, :party

  Monsters = YAML.load(File.read('yaml/monsters.yaml'))

  def initialize keys
    @keys = keys
    @monsters = create_monsters
  end

  def run party
    @party = party
    get_ready
    play_round until over
    outcome
  end

  def renew
    Encounter.new keys
  end

  private

  def outcome
    Outcome.new party
  end

  def over
    party.all?(&:dead) || monsters.all?(&:dead)
  end

  def play_round
    characters.sort_by(&:initiative).reverse.each do |character|
      character.take_turn unless character.dead
      break if over
    end
  end

  def characters
    party + monsters
  end

  def get_ready
    party.each { |character| character.foes = monsters }
    monsters.each { |monster| monster.foes = party }
    characters.each(&:roll_initiative)
  end

  def create_monsters
    keys.map.with_index 1 do |key, i|
      Character.new Monsters[key], "#{key.capitalize}-#{i}"
    end
  end
end
