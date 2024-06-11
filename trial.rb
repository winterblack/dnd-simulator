require 'yaml'
require_relative 'characters/player_character'
require_relative 'characters/rogue/rogue'

class Trial
  attr_reader :count, :outcomes, :party, :scenario

  Characters = YAML.load(File.read('yaml/characters.yaml'))

  def initialize scenario
    @scenario = scenario
    @count = 100
    @outcomes = []
  end

  def run party
    @party = party
    count.times do |i|
      start_trial i
      outcomes << scenario.renew.run(renew_party)
    end
    self
  end

  def print_outcome
    print "\n Ran the scenario #{count} times"
    print "\n Chance of TPK: #{tpk_chance}%"
    print "\n Chance all survive: #{all_survive_chance}%"
    print "\n Chance unscathed: #{unscathed_chance}% \n"
  end

  private

  def unscathed_chance
    outcomes.count(&:unscathed?) * 100 / count
  end

  def all_survive_chance
    outcomes.count(&:all_survive?) * 100 / count
  end

  def tpk_chance
    outcomes.count(&:tpk?) * 100 / count
  end

  def renew_party
    party.map do |character|
      case character
      when 'rogue' then Rogue.new(Characters[character])
      else PlayerCharacter.new(Characters[character])
      end
    end
  end

  def start_trial i
    print "\nStarting trial #{i + 1}\n\n" if $VERBOSE
  end
end
