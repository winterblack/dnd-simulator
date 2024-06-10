require_relative '../logs'

module PositioningLogs
  include Logs

  def opportunity_attack foe
    log "#{name} makes an opportunity attack against #{foe.name}" unless foe.dead
    super foe
    log "#{foe.name} drops dead at #{name}'s feet" if foe.dead
  end
end
