=begin
%%{

  machine ephemeris_parser;

  action mark { mark = p }

  action target_body_id {
    target_body_id = data[mark..p].pack('c*')
  }

  action center_body_id {
    center_body_id = data[mark..p].pack('c*')
  }

  action start_time {
    start_time = data[mark..p].pack('c*')
  }

  action stop_time {
    stop_time = data[mark..p].pack('c*')
  }

  action step_size {
    step_size = data[mark..p].pack('c*')
  }

  action ephemeris_table {
    ephemeris_table = data[mark..p].pack('c*')
  }

  action ephemeris_columns {
    ephemeris_columns = data[mark..p].pack('c*')
  }

  ws = [ \t\r\n];

  adbc = ('A.D.'|'B.C.');
  year = digit{4};
  month = upper lower{2};
  date = digit{2};
  hours =  digit{2};
  minutes = digit{2};
  seconds = digit{2} '.' digit{4};
  tz = ('C'|'U') 'T';
  datetime = adbc ' ' year '-' month '-' date ' ' hours ':' minutes ':' seconds ' ' tz;

  hr = '*'+ '\n';

  time_unit = ('minute' [s]? | 'calendar year' [s]?);

  body_name = (alnum | space)*;
  body_id = digit*;

  target_body = 'Target body name:' space body_name space
    '(' body_id >mark @target_body_id ')'
    ws* '{' any* '}' '\n';

  center_body = 'Center body name:' space body_name space
    '(' body_id >mark @center_body_id ')'
    ws* '{' any* '}' '\n';

  start_time = 'Start time' ' '* ':' ' ' datetime >mark %start_time space* '\n';
  stop_time  = 'Stop  time' ' '* ':' ' ' datetime >mark %stop_time space* '\n';
  step_size  = 'Step-size' ' '* ':' ' ' (digit+ ' '* time_unit) >mark $step_size '\n';

  ephemeris_columns = (
    ('JDCT' | 'Date__(UT)__HR:MN')
    (' ' | alpha | ',')*) >mark @ephemeris_columns '\n';

  soe = '$$SOE' '\n';
  eoe = '$$EOE' '\n';
  ephemeris_table = any*;
  ephemeris = soe any* >mark @ephemeris_table :> eoe;

  main := (
    any*
    target_body
    center_body
    any*
    start_time
    stop_time
    step_size
    any*
    hr
    ephemeris_columns
    hr
    ephemeris
    any*
  );

}%%
=end

require 'date'
module Tengai
  class VectorEphemerisParser
    def self.parse(data, delegate)
      data = data.unpack('c*') if data.is_a? String
      eof = data.length

      %% write init;
      %% write exec;

      delegate.target_body_id  = target_body_id.to_i
      delegate.center_body_id  = center_body_id.to_i
      delegate.start_time      = DateTime.parse(start_time)
      delegate.stop_time       = DateTime.parse(stop_time)
      delegate.step_size       = step_size
      delegate.ephemeris_columns = ephemeris_columns
      delegate.ephemeris_table = ephemeris_table
    end

    %% write data;
  end
end
