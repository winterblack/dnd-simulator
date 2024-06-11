require_relative 'target_value'

class Action
  attr_reader :character, :range, :target

  def initialize character
    @character = character
  end

  def perform
    # implement in action
  end

  def evaluate
    target_value = evaluate_targets.max_by(&:value)
    @target = target_value.target
    target_value.value
  end

  def valid?
    valid_targets.any?
  end

  private

  def evaluate_target target
    # implement in action
  end

  def valid_targets
    character.valid_foes range
  end

  def evaluate_targets
    valid_targets.map do |target|
      TargetValue.new(target, evaluate_target(target))
    end
  end
end
