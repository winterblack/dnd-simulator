require_relative '../logs'

module AttackLogs
  include Logs

  private

  def sneaking?
  end

  def sneak_attacks?
    sneaking? ? 'sneak attacks' : 'hits'
  end

  def move_into_position
    log "#{attacker} moves #{@movement} feet to attack #{defender}" if @movement > 0
  end

  def miss
    log "#{attacker} misses #{defender} with #{name}"
  end

  def roll_damage
    @damage = super
  end

  def hit
    super
    log "#{attacker} #{sneak_attacks?} #{defender} with #{name} for #{@damage} damage"
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
