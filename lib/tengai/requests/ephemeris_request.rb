module Tengai
  class EphemerisRequest
    attr_reader :state, :data

    DEFAULT_PROMPT = /<cr>:\s*$/
    TABLE_PROMPT = /Observe, Elements, Vectors  \[o,e,v,\?\] :\s*$/.freeze
    FIRST_OBSERVER_PROMPT = /Coordinate center \[ <id>,coord,geo  \] :\s*$/.freeze
    SUBSEQUENT_OBSERVER_PROMPT = /Use previous center  \[ cr=\(y\), n, \? \] :\s*$/.freeze
    OBSERVER_PROMPT = Regexp.union(FIRST_OBSERVER_PROMPT, SUBSEQUENT_OBSERVER_PROMPT).freeze
    START_TIME_PROMPT = /Starting UT  \[>=   1900-Jan-04 00:01\] :\s*$/.freeze
    END_TIME_PROMPT = /Ending   UT  \[<=   2100-Jan-02 23:58\] :\s*$/.freeze
    INTERVAL_PROMPT = /Output interval \[ex: 10m, 1h, 1d, \? \] :\s*$/.freeze
    ACCEPT_DEFAULT_OUTPUT_PROMPT = /Accept default output \[ cr=\(y\), n, \?\] :\s*$/.freeze
    SELECT_QUANTITIES_PROMPT = /Select table quantities \[ <#,#\.\.>, \?\] :\s*$/.freeze
    COMPLETED_PROMPT = />>> Select\.\.\. \[A\]gain, \[N\]ew-case, \[F\]tp, \[K\]ermit, \[M\]ail, \[R\]edisplay, \? :\s*$/.freeze

    ANY_PROMPT = Regexp.union(
      DEFAULT_PROMPT, TABLE_PROMPT, OBSERVER_PROMPT, START_TIME_PROMPT,
      END_TIME_PROMPT, INTERVAL_PROMPT, ACCEPT_DEFAULT_OUTPUT_PROMPT,
      SELECT_QUANTITIES_PROMPT, COMPLETED_PROMPT, Client::PROMPT).freeze

    TIME_FORMAT = '%Y-%b-%d %H:%M'.freeze

    def initialize(client, body, options={})
      @client = client
      @body = body.to_s
      @start_time = options[:start_time]
      @end_time = options[:end_time]
      @state = :ready
    end

    # Public: initiates the ephemeris request
    #
    # Examples:
    #
    #   Tengai::EphemerisRequest.new(Tengai::Client.new, 499).fetch
    #   # => #<Tengai::EphemerisRequest @data=""B\n \r\n Working ...   \b\b-  \r\n\e[?1h\e=\r*...">
    #
    # Returns the the request (self)
    def fetch
      raise "Not ready" unless state == :ready
      @state = :fetching
      send_command(@body)
      self
    end

    private
    def send_command(command, prompt=ANY_PROMPT)
      result = @client.cmd('String' => command, 'Match' => prompt) do |data|
        Tengai.log data
      end
      receive_data(result)
    end

    def receive_data(data)
      case data
      when DEFAULT_PROMPT
        send_command('E')
      when TABLE_PROMPT
        send_command('o')
      when FIRST_OBSERVER_PROMPT
        send_command('geo')
      when SUBSEQUENT_OBSERVER_PROMPT
        send_command('y')
      when START_TIME_PROMPT
        send_command(@start_time.strftime(TIME_FORMAT))
      when END_TIME_PROMPT
        send_command(@end_time.strftime(TIME_FORMAT))
      when INTERVAL_PROMPT
        send_command('1d')
      when ACCEPT_DEFAULT_OUTPUT_PROMPT
        send_command('y')
      when SELECT_QUANTITIES_PROMPT
        send_command('B')
      when COMPLETED_PROMPT
        @data = data
        send_command('N')
      when Client::PROMPT
        @state = :ready
      else
        puts "Unexpected data: #{data}"
      end
    end
  end
end
