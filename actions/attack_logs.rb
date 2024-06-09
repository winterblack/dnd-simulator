module AttackLogs
  private

  def miss
    p "#{attacker} misses #{defender} with #{name}"
  end

  def roll_damage
    @damage = super
  end

  def hit
    super
    p "#{attacker} hits #{defender} with #{name} for #{@damage} damage"
  end

  def name
    @name || self.class
  end

  def attacker
    character.name
  end

  def defender
    target.name
  end
end
