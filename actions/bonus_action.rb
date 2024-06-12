class BonusAction
  attr_reader :character, :value

  def initialize character
    @character = character
  end

  def perform
    # implement in bonus action
  end

  def evaluate
    # implement in bonus action
  end

  def valid?
    # implement in bonus action
  end
end
