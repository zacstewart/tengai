module Tengai
  class TelnetEphemerisRequest
    module Prompts
      SYSTEM = %r{Horizons>}.freeze
      DEFAULT = %r{<cr>:\s*$}
      TABLE = %r{Observe, Elements, Vectors  \[o,e,v,\?\] :\s*$}.freeze
      FIRST_OBSERVER = %r{Coordinate center \[ <id>,coord,geo  \] :\s*$}.freeze
      SUBSEQUENT_OBSERVER = %r{Use previous center  \[ cr=\(y\), n, \? \] :\s*$}.freeze
      OBSERVER = Regexp.union(FIRST_OBSERVER, SUBSEQUENT_OBSERVER).freeze
      CONFIRM_OBSERVER = %r{Confirm selected station    \[ y/n \] -->\s*$}.freeze
      REFERNCE_PLANE = %r{Reference plane \[eclip, frame, body \] :\s*}.freeze
      START_TIME = %r{Starting (C|U)T .* :\s*$}.freeze
      END_TIME = %r{Ending \s* (C|U)T .* :\s*$}.freeze
      INTERVAL = %r{Output interval \[ex: 10m, 1h, 1d, \? \] :\s*$}.freeze
      ACCEPT_DEFAULT_OUTPUT = %r{Accept default output \[ cr=\(y\), n, \?\] :\s*$}.freeze
      OUTPUT_REFERENCE_FRAME = %r{Output reference frame \[J2000, B1950\] :\s*$}.freeze
      CORRECTIONS = %r{Corrections \[ 1=NONE, 2=LT, 3=LT\+S \]  :\s*$}.freeze
      OUTPUT_UNITS = %r{Output units \[1=KM-S, 2=AU-D, 3=KM-D\] :\s*$}.freeze
      CSV_FORMAT = %r{Spreadsheet CSV format    \[ YES, NO \] :\s*$}.freeze
      LABEL_CARTESIAN_OUTPUT = %r{Label cartesian output    \[ YES, NO \] :\s*$}.freeze
      SELECT_OUTPUT_TABLE_TYPE = %r{Select output table type  \[ 1-6, \?  \] :\s*$}.freeze
      SELECT_QUANTITIES = %r{Select table quantities \[ <#,#\.\.>, \?\] :\s*$}.freeze
      COMPLETED = %r{>>> Select\.\.\. \[A\]gain, \[N\]ew-case, \[F\]tp, \[K\]ermit, \[M\]ail, \[R\]edisplay, \? :\s*$}.freeze

      ANY = Regexp.union(
        DEFAULT, TABLE, OBSERVER, CONFIRM_OBSERVER, REFERNCE_PLANE, START_TIME,
        END_TIME, INTERVAL, ACCEPT_DEFAULT_OUTPUT, SELECT_QUANTITIES,
        COMPLETED, OUTPUT_REFERENCE_FRAME, CORRECTIONS, OUTPUT_UNITS,
        CSV_FORMAT, LABEL_CARTESIAN_OUTPUT, SELECT_OUTPUT_TABLE_TYPE,
        SYSTEM).freeze
    end

    TIME_FORMAT = '%Y-%b-%d %H:%M'.freeze

    SOLAR_SYSTEM_BARYCENTER = '500@0'.freeze

    def initialize(client, body, options={})
      @client     = client
      @body       = body.to_s
      @start_time = options.fetch(:start_time)
      @stop_time  = options.fetch(:stop_time)
      @interval   = options.fetch(:interval) { 1440 }
      @options    = options
      @state      = :ready
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
      @options.fetch(:observer) { SOLAR_SYSTEM_BARYCENTER }
    end

    def send_command(command, prompt=Prompts::ANY)
      Tengai.log "> #{command}"
      result = @client.cmd('String' => command, 'Match' => prompt) do |data|
        Tengai.log '< ' + data
      end
      receive_data(result)
    end

    def receive_data(data)
      case data
      when Prompts::DEFAULT
        send_command 'E'
      when Prompts::TABLE
        send_command table
      when Prompts::FIRST_OBSERVER
        send_command observer
      when Prompts::SUBSEQUENT_OBSERVER
        send_command 'n'
      when Prompts::CONFIRM_OBSERVER
        send_command 'y'
      when Prompts::REFERNCE_PLANE
        send_command 'frame'
      when Prompts::START_TIME
        send_command @start_time.strftime(TIME_FORMAT)
      when Prompts::END_TIME
        send_command @stop_time.strftime(TIME_FORMAT)
      when Prompts::INTERVAL
        send_command @interval.to_s + 'm'
      when Prompts::ACCEPT_DEFAULT_OUTPUT
        send_command 'n'
      when Prompts::OUTPUT_REFERENCE_FRAME
        send_command 'J2000'
      when Prompts::CORRECTIONS
        send_command '1'
      when Prompts::OUTPUT_UNITS
        send_command '2'
      when Prompts::CSV_FORMAT
        send_command 'YES'
      when Prompts::LABEL_CARTESIAN_OUTPUT
        send_command 'YES'
      when Prompts::SELECT_OUTPUT_TABLE_TYPE
        send_command '03'
      when Prompts::SELECT_QUANTITIES
        send_command 'B'
      when Prompts::COMPLETED
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
