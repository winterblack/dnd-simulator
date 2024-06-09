class Encounter
  attr_reader :monsters

  def initialize monsters
    @monsters = monsters
  end

  def run party
    p party.join ' '
    p 'vs'
    p monsters.join ' '
  end
end
