require 'optparse'

class Options
  def initialize
    option_parser.parse!
  end

  private

  def option_parser
    OptionParser.new do |parser|
      parser.on('--verbose', 'Include detailed logs') do
        $VERBOSE = true
      end
    end
  end
end
