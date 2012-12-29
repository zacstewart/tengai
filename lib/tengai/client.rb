require 'net/telnet'

module Tengai
  class Client
    HOST = 'horizons.jpl.nasa.gov'.freeze
    PORT = '6775'.freeze
    PROMPT = 'Horizons>'.freeze

    def initialize(telnet=Net::Telnet)
      @telnet = telnet
      connect!
    end

    def connect!
      @connection = @telnet.new(
        'Host'   => HOST,
        'Port'   => PORT,
        'Prompt' => PROMPT)
      @connection.waitfor 'Match' => Regexp.new(PROMPT)
    end

    def disconnect
      @connection.close
    end

    def connection
      @connection
    end

    def cmd(*args)
      connection.cmd(*args)
    end
  end
end
