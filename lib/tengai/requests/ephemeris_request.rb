module Tengai
  class EphemerisRequest
    DEFAULT_PROMPT = %r{<cr>:\s*$}
    TABLE_PROMPT = %r{Observe, Elements, Vectors  \[o,e,v,\?\] :\s*$}.freeze
    FIRST_OBSERVER_PROMPT = %r{Coordinate center \[ <id>,coord,geo  \] :\s*$}.freeze
    SUBSEQUENT_OBSERVER_PROMPT = %r{Use previous center  \[ cr=\(y\), n, \? \] :\s*$}.freeze
    OBSERVER_PROMPT = Regexp.union(FIRST_OBSERVER_PROMPT, SUBSEQUENT_OBSERVER_PROMPT).freeze
    CONFIRM_OBSERVER_PROMPT = %r{Confirm selected station    \[ y/n \] -->\s*$}.freeze
    REFERNCE_PLANE_PROMPT = %r{Reference plane \[eclip, frame, body \] :\s*}.freeze
    START_TIME_PROMPT = %r{Starting (C|U)T .* :\s*$}.freeze
    END_TIME_PROMPT = %r{Ending \s* (C|U)T .* :\s*$}.freeze
    INTERVAL_PROMPT = %r{Output interval \[ex: 10m, 1h, 1d, \? \] :\s*$}.freeze
    ACCEPT_DEFAULT_OUTPUT_PROMPT = %r{Accept default output \[ cr=\(y\), n, \?\] :\s*$}.freeze
    OUTPUT_REFERENCE_FRAME_PROMPT = %r{Output reference frame \[J2000, B1950\] :\s*$}.freeze
    CORRECTIONS_PROMPT = %r{Corrections \[ 1=NONE, 2=LT, 3=LT\+S \]  :\s*$}.freeze
    OUTPUT_UNITS = %r{Output units \[1=KM-S, 2=AU-D, 3=KM-D\] :\s*$}.freeze
    CSV_FORMAT_PROMPT = %r{Spreadsheet CSV format    \[ YES, NO \] :\s*$}.freeze
    LABEL_CARTESIAN_OUTPUT_PROMPT = %r{Label cartesian output    \[ YES, NO \] :\s*$}.freeze
    SELECT_OUTPUT_TABLE_TYPE_PROMPT = %r{Select output table type  \[ 1-6, \?  \] :\s*$}.freeze
    SELECT_QUANTITIES_PROMPT = %r{Select table quantities \[ <#,#\.\.>, \?\] :\s*$}.freeze
    COMPLETED_PROMPT = %r{>>> Select\.\.\. \[A\]gain, \[N\]ew-case, \[F\]tp, \[K\]ermit, \[M\]ail, \[R\]edisplay, \? :\s*$}.freeze

    ANY_PROMPT = Regexp.union(
      DEFAULT_PROMPT, TABLE_PROMPT, OBSERVER_PROMPT, CONFIRM_OBSERVER_PROMPT,
      REFERNCE_PLANE_PROMPT, START_TIME_PROMPT, END_TIME_PROMPT, INTERVAL_PROMPT,
      ACCEPT_DEFAULT_OUTPUT_PROMPT, SELECT_QUANTITIES_PROMPT, COMPLETED_PROMPT,
      OUTPUT_REFERENCE_FRAME_PROMPT, CORRECTIONS_PROMPT, OUTPUT_UNITS,
      CSV_FORMAT_PROMPT, LABEL_CARTESIAN_OUTPUT_PROMPT,
      SELECT_OUTPUT_TABLE_TYPE_PROMPT, Client::PROMPT).freeze

    TIME_FORMAT = '%Y-%b-%d %H:%M'.freeze

    def initialize(client, body, options={})
      @client = client
      @body = body.to_s
      @start_time = options[:start_time]
      @stop_time = options[:stop_time]
      @options = options
      @state = :ready
    end

    def self.fetch(client, body, options={})
      new(client, body, options).fetch
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
      raise "Not ready" unless @state == :ready
      @state = :fetching
      send_command(@body)
      @data
    end

    private
    def table
      case @options[:table]
      when :observer then 'o'
      when :vector then 'v'
      when :orbital_elements then 'e'
      else 'v'
      end
    end

    def observer
      @options[:observer] || '500@0'
    end

    def send_command(command, prompt=ANY_PROMPT)
      Tengai.log "> #{command}"
      result = @client.cmd('String' => command, 'Match' => prompt) do |data|
        Tengai.log '< ' + data
      end
      receive_data(result)
    end

    def receive_data(data)
      case data
      when DEFAULT_PROMPT
        send_command 'E'
      when TABLE_PROMPT
        send_command table
      when FIRST_OBSERVER_PROMPT
        send_command observer
      when SUBSEQUENT_OBSERVER_PROMPT
        send_command 'n'
      when CONFIRM_OBSERVER_PROMPT
        send_command 'y'
      when REFERNCE_PLANE_PROMPT
        send_command 'frame'
      when START_TIME_PROMPT
        send_command @start_time.strftime(TIME_FORMAT)
      when END_TIME_PROMPT
        send_command @stop_time.strftime(TIME_FORMAT)
      when INTERVAL_PROMPT
        send_command '1d'
      when ACCEPT_DEFAULT_OUTPUT_PROMPT
        send_command 'n'
      when OUTPUT_REFERENCE_FRAME_PROMPT
        send_command 'J2000'
      when CORRECTIONS_PROMPT
        send_command '1'
      when OUTPUT_UNITS
        send_command '2'
      when CSV_FORMAT_PROMPT
        send_command 'YES'
      when LABEL_CARTESIAN_OUTPUT_PROMPT
        send_command 'YES'
      when SELECT_OUTPUT_TABLE_TYPE_PROMPT
        send_command '03'
      when SELECT_QUANTITIES_PROMPT
        send_command 'B'
      when COMPLETED_PROMPT
        @data = data
        send_command 'N'
      when Client::PROMPT
        @state = :ready
      else
        puts "Unexpected data: #{data}"
      end
    end
  end
end
