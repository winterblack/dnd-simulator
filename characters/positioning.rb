module Positioning
  attr_reader :dashing, :position

  def dash_forward
    @dashing = true
    move_into_position(nearest_foe, weapon.range)
    @dashing = false
  end

  def move_into_position target, range
    move(movement_into_position(target, range))
  end

  def valid_foes range
    living_foes.select { |foe| distance_to(foe) <= range }
  end

  private

  def nearest_foe
    living_foes.min_by { |foe| distance_to foe }
  end

  def movement_into_position target, range
    distance = distance_to(target) - weapon.range
    direction = direction_to target
    limit_speed(distance * direction)
  end

  def limit_speed displacement
    distance = distance_of displacement
    direction = direction_of displacement
    max_distance = dashing ? speed * 2 : speed
    distance > max_distance ? max_distance * direction : distance * direction
  end

  def move displacement
    @position += displacement
  end

  def displacement_to target
    target.position - position
  end

  def direction_of displacement
    displacement.positive? ? 1 : -1
  end

  def distance_of displacement
    displacement.abs
  end

  def direction_to target
    direction_of(displacement_to(target))
  end

  def distance_to target
    distance_of(displacement_to(target))
  end
end
