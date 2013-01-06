=begin
%%{

  machine ephemeris_parser;

  integer     = ('+'|'-')?[0-9]+;
  datetime = ('A.D.'|'B.C.') [0-9]{4}'-'[A-Z][a-z]{2}'-'[0-9]{2} [0-9]{2}':'[0-9]{2}':'[0-9]{2}'.'[0-9]{4}'UT';
  identifier  = [a-zA-Z][a-zA-Z_]+;
  begin_start_time = 'Start time';
  begin_stop_time = 'Stop  time';
  ad = ('A.D.'|'B.C.') space integer{4};
  hr = '*******************************************************************************';
  soe = '$$SOE';
  eoe = '$$EOE';
  begin_ephemeris = [0-9]{4};
  ws = [ \t\r\n];

  action myTs { my_ts = p }
  action myTe { my_te = p }

  action parse_start_time {
    parser.start_time = data[my_ts..my_te].pack('c*')
  }

  action parse_stop_time {
    parser.stop_time = data[my_ts..my_te].pack('c*')
  }

  action parse_ephemeris_table {
    parser.ephemeris = data[my_ts..p].pack('c*')
  }

  start_time = begin_start_time ws* ':' ws* any* >myTs :>> [\r\n] >myTe >parse_start_time;
  stop_time = begin_stop_time ws* ':' ws* any* >myTs :>> [\r\n] >myTe >parse_stop_time;
  ephemeris = soe any* >myTs :>> eoe >parse_ephemeris_table;

  main := (
    any*
    start_time
    any*
    stop_time*
    any*
    ephemeris
    any*
  );

}%%
=end

require 'date'

module Tengai
  EPHEMERIS_DATA = Struct.new(:start_time, :stop_time, :ephemeris).freeze

  class EphemerisParser < EPHEMERIS_DATA
    def self.parse(data)
      parser = new
      data = data.unpack('c*') if data.is_a? String
      eof = data.length

      %% write init;
      %% write exec;

      parser
    end

    %% write data;
  end
end
