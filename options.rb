require 'optparse'

class Options
  attr_reader :encounter_options

  def initialize
    @encounter_options = {}
    option_parser.parse!
  end

  private

  def option_parser
    OptionParser.new do |parser|
      parser.on('--verbose', 'Include detailed logs') do
        $VERBOSE = true
      end
      parser.on('--render', 'Render character positions') do
        encounter_options[:render] = true
      end
    end
  end
end
