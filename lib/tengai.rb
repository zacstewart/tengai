$:.unshift File.dirname(__FILE__)
$:.unshift File.join(File.dirname(File.dirname(__FILE__)), 'ext')

require 'logger'

require 'tengai/version'
require 'tengai/client'
require 'tengai/body'
require 'tengai/ephemeris'

require 'horizons/ephemeris_parser'

module Tengai
  class << self
    attr_accessor :debug
    attr_reader :logger

    def log(message)
      logger.debug { message } if debug
    end
  end

  @logger ||= ::Logger.new(STDOUT)

  self.debug = false
end
