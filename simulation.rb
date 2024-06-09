require_relative 'encounter'
require_relative 'trial'

def run_simulation
  Simulation.new.run
end

class Simulation
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

run_simulation if __FILE__ == $PROGRAM_NAME
