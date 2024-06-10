require_relative 'action'

class Dash < Action
  def perform
    character.dash_forward
  end

  def evaluate
    0
  end

  def valid?
    true
  end
end
