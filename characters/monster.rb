require_relative 'character'

class Monster < Character
  def initialize character, name
    super character
    @name = name
    @position = 30
  end
end
