require_relative 'encounter'
require_relative 'options'
require_relative 'trial'

class Simulation
  attr_reader :encounter_options

  def initialize
    options = Options.new
    @encounter_options = options.encounter_options
  end

  def run
    Trial.new(scenario).run(party).print_outcome
  end

  private

  def party
    ['cleric', 'fighter', 'rogue', 'wizard']
  end

  def monsters
    Array.new(8) { 'kobold' }
  end

  def scenario
    Encounter.new(monsters, encounter_options)
  end
end

Simulation.new.run if __FILE__ == $PROGRAM_NAME
