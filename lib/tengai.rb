$:.unshift File.dirname(__FILE__)

require 'logger'

require 'tengai/version'
require 'tengai/client'
require 'tengai/body'
require 'tengai/ephemeris'

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
