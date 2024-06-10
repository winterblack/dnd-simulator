module Move
  def perform
    super
    character.move_into_position target, range
  end

  private

  def valid_targets
    character.valid_foes(range + character.speed)
  end
end
