module Logs
  private

  def log message
    p message if $VERBOSE
  end
end
