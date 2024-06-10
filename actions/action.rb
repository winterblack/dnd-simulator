require_relative 'target_value'

class Action
  attr_reader :character, :evaluated_targets, :range, :target

  def initialize character
    @character = character
  end

  def perform
    @target = choose_target
    # implement in action
  end

  def evaluate
    @evaluated_targets = evaluate_targets
    evaluated_targets.map(&:value).max
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

  def choose_target
    evaluated_targets.max_by(&:value).target
  end
end
