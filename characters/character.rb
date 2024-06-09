class Character
  attr_reader :str, :dex, :con, :int, :wis, :cha,
              :ac, :hp, :level, :name, :speed, :weapon

  def initialize character, name = nil
    @name = name || character['name']
    @str = character['str']
    @dex = character['dex']
    @con = character['con']
    @int = character['int']
    @wis = character['wis']
    @cha = character['cha']
    @ac = character['ac']
    @hp = character['hp']
    @level = character['level'] || character['challenge']
    @speed = character['speed']
    @weapon = character['weapon']
  end

  private

  def inspect
    "<#{name} ac:#{ac} hp:#{hp} #{weapon}>"
  end
end
