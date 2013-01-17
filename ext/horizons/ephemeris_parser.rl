=begin
%%{

  machine ephemeris_parser;

  action mark { mark = p }

  action target_body_id {
    parser.target_body_id = data[mark..p].pack('c*')
  }

  action center_body_id {
    parser.center_body_id = data[mark..p].pack('c*')
  }

  action parse_start_time {
    parser.start_time = data[mark..p].pack('c*')
  }

  action parse_stop_time {
    parser.stop_time = data[mark..p].pack('c*')
  }

  action parse_step_size {
    parser.step_size = data[mark..p].pack('c*')
  }

  action parse_ephemeris_table {
    parser.ephemeris_table = data[mark..p].pack('c*')
  }

  ws = [ \t\r\n];

  adbc = ('A.D.'|'B.C.');
  year = digit{4};
  month = upper lower{2};
  date = digit{2};
  hours =  digit{2};
  minutes = digit{2};
  seconds = digit{2} '.' digit{4};
  tz = 'UT';
  datetime = adbc ' ' year '-' month '-' date ' ' hours ':' minutes ':' seconds ' ' tz;

  time_unit = ('minute' [s]? | 'calendar year' [s]?);

  soe = '$$SOE' '\n';
  eoe = '$$EOE' '\n';
  ephemeris_table = (alnum | ws | [*-./:])*;

  body_name = (alnum | space)*;
  body_id = digit*;

  target_body = 'Target body name:' space body_name space
    '(' body_id >mark @target_body_id ')'
    ws* '{' any* '}' '\n';

  center_body = 'Center body name:' space body_name space
    '(' body_id >mark @center_body_id ')'
    ws* '{' any* '}' '\n';

  start_time = 'Start time' ' '* ':' ' ' datetime >mark %parse_start_time space* '\n';
  stop_time  = 'Stop  time' ' '* ':' ' ' datetime >mark %parse_stop_time space* '\n';
  step_size  = 'Step-size' ' '* ':' ' ' (digit+ ' '* time_unit) >mark $parse_step_size '\n';

  ephemeris = soe ephemeris_table >mark @parse_ephemeris_table eoe;

  main := (
    any*
    target_body
    center_body
    any*
    start_time
    stop_time
    step_size
    any*
    ephemeris
    any*
  );

}%%
=end

require 'date'

module Tengai
  EPHEMERIS_DATA = Struct.new(:target_body_id, :center_body_id, :start_time, :stop_time, :step_size, :ephemeris_table).freeze

  class EphemerisParser < EPHEMERIS_DATA
    def self.parse(data)
      parser = new
      data = data.unpack('c*') if data.is_a? String
      eof = data.length

      %% write init;
      %% write exec;

      parser
    end

    def target_body_id=(id)
      super id.to_i
    end

    def center_body_id=(id)
      super id.to_i
    end

    def start_time=(time)
      super parse_time(time)
    end

    def stop_time=(time)
      super parse_time(time)
    end

    %% write data;

    # % fix syntax highlighting

    private
    def parse_time(time)
      DateTime.parse(time)
    end
  end
end
