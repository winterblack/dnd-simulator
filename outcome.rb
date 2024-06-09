class Outcome
  attr_reader :party

  def initialize party
    @party = party
  end

  def unscathed?
    party.all? { |character| character.hp == character.current_hp }
  end

  def all_survive?
    party.none?(&:dead)
  end

  def tpk?
    party.all?(&:dead)
  end
end
