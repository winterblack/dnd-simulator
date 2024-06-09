class Attribute
  attr_reader :value, :bonus

  def initialize value
    @value = value
    @bonus = value / 2 - 5
  end
end
