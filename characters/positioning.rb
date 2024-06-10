module Positioning
  attr_reader :dashing, :position

  def dash movement
    @dashing = true
    move movement
    @dashing = false
  end

  def nearest_foe
    living_foes.min_by { |foe| distance_to(foe) }
  end

  def move movement
    @position += limit_speed(movement)
  end

  def movement_into_position target, range
    direction_to(target) * (distance_to(target) - range)
  end

  def evaluate_risk destination
    evaluate_threats(destination).sum
  end

  def valid_foes range
    living_foes.select { |foe| distance_to(foe) <= range }
  end

  private

  def melee_foes
    living_foes.reject { |foe| foe.weapon.ranged }
  end

  def threatening_foes
    melee_foes.select { |foe| foe.has_reaction }
  end

  def within_reach_of foe
    distance_to(foe) <= foe.weapon.range
  end

  def foes_in_direction_of destination
    threatening_foes.select do |foe|
      direction_to(foe) == direction_of(destination) || within_reach_of(foe)
    end
  end

  def foes_in_path_of destination
    foes_in_direction_of(destination).select do |foe|
      (foe.position - destination).abs > foe.weapon.range
    end
  end

  def evaluate_threat foe
    foe.weapon.evaluate_target self
  end

  def evaluate_threats destination
    foes_in_path_of(destination).map { |foe| evaluate_threat(foe) }
  end

  def limit_speed movement
    distance = distance_of movement
    direction = direction_of movement
    max_distance = dashing ? speed * 2 : speed
    distance > max_distance ? max_distance * direction : distance * direction
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
