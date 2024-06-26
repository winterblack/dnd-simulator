module Move
  attr_reader :destination

  def perform
    move_into_position
    super
  end

  private

  def destination
    character.position + movement_into_position
  end

  def move_into_position
    @movement = movement_into_position
    character.move(@movement)
    super
  end

  def movement_into_position
    character.movement_into_position target, range
  end

  def evaluate_risk
    character.evaluate_risk(destination)
  end

  def evaluate_target target
    super(target) - evaluate_risk
  end

  def valid_targets
    character.valid_foes(range + character.speed)
  end
end
