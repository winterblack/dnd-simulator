require 'yaml'
require_relative 'characters/character'

class Encounter
  attr_reader :monsters, :party

  Monsters = YAML.load(File.read('yaml/monsters.yaml'))

  def initialize keys
    @monsters = create_monsters keys
  end

  def run party
    @party = party
    get_ready
    play_round until over
  end

  private

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

  def create_monsters keys
    keys.map.with_index 1 do |key, i|
      Character.new Monsters[key], "#{key.capitalize}-#{i}"
    end
  end
end
