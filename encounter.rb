require 'yaml'
require_relative 'characters/character'

class Encounter
  attr_reader :monsters

  Monsters = YAML.load(File.read('yaml/monsters.yaml'))

  def initialize keys
    @monsters = create_monsters keys
  end

  def run party
    p party
    p 'vs'
    p monsters
  end

  private

  def create_monsters keys
    keys.map.with_index 1 do |key, i|
      Character.new Monsters[key], "#{key.capitalize}-#{i}"
    end
  end
end
