require_relative 'action'

class Dash < Action
  def perform
    character.dash movement_into_position
  end

  def evaluate
    0
  end

  def valid?
    true
  end

  private

  def range
    character.weapon.range
  end

  def target
    character.nearest_foe
  end

  def movement_into_position
    character.movement_into_position target, range
  end
end
