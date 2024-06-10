require 'yaml'
require_relative 'characters/monster'
require_relative 'outcome'

class Encounter
  attr_reader :keys, :monsters, :options, :party

  Monsters = YAML.load(File.read('yaml/monsters.yaml'))

  def initialize keys, options
    @keys = keys
    @options = options
    @monsters = create_monsters
  end

  def run party
    @party = party
    get_ready
    play_round until over
    outcome
  end

  def renew
    Encounter.new keys, options
  end

  private

  def render_positions
    positions = (-16..6).to_a.reverse.map { |i| i * 5 }
    positions.each do |position|
      print "#{position} "
      p characters.select { |char| char.position == position }
    end
    sleep 1
    system("echo \"\r#{"\033[1A\033[0K" * (positions.count + 1)}\"")
  end

  def outcome
    Outcome.new party
  end

  def over
    party.all?(&:dead) || monsters.all?(&:dead)
  end

  def play_round
    characters.sort_by(&:initiative).reverse.each do |character|
      render_positions if options[:render]
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
      Monster.new Monsters[key], "#{key.capitalize}-#{i}"
    end
  end
end
