require 'net/telnet'

module Tengai
  class Client
    PROMPT = 'Horizons>'.freeze

    def initialize(options={})
      connect!
    end

    def connect!
      @connection = Net::Telnet::new(
        'Host'   => 'horizons.jpl.nasa.gov',
        'Port'   => '6775',
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
