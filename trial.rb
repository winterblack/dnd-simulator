require 'yaml'
require_relative 'characters/character'

class Trial
  attr_reader :party, :scenario

  Characters = YAML.load(File.read('yaml/characters.yaml'))

  def initialize scenario
    @scenario = scenario
  end

  def run party
    @party = party
    scenario.run renew_party
  end

  private

  def renew_party
    party.map do |character|
      Character.new(Characters[character])
    end
  end
end
