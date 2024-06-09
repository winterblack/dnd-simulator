class Trial
  attr_reader :scenario

  def initialize scenario
    @scenario = scenario
  end

  def run party
    scenario.run party
  end
end
