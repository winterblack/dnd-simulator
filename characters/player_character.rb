require_relative 'character'

class PlayerCharacter < Character
  def initialize character
    super character
    @name = character['name']
    @position = weapon.ranged ? -30 : 0
  end
end
