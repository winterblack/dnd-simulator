module RangedAttack
  attr_reader :destination

  private

  def close_combat?
    position = destination || character.position
    character.foes_within_radius_of(position, 5).any?
  end

  def advantage_disadvantage
    return :disadvantage if close_combat?
  end
end
