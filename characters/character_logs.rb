require_relative '../logs'

module CharacterLogs
  include Logs

  def heal healing
    super healing
    log "#{name} heals for #{@healing}. HP: #{current_hp}/#{hp}"
  end

  def opportunity_attack foe
    log "#{name} makes an opportunity attack against #{foe.name}" unless foe.dead
    super foe
    log "#{foe.name} drops dead at #{name}'s feet" if foe.dead
  end
end
