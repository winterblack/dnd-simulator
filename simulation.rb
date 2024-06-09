require_relative 'encounter'
require_relative 'options'
require_relative 'trial'

class Simulation
  def initialize
    Options.new
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
    Encounter.new(monsters)
  end
end

Simulation.new.run if __FILE__ == $PROGRAM_NAME
