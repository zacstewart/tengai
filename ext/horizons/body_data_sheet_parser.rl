=begin
%%{
  machine body_data_sheet_parser;

  action mark { mark = p }

  action revised_on {
    @body.revised_on = Date.parse(data[mark..p].pack('c*'))
  }

  action name {
    @body.name = data[mark..p - 1].pack('c*')
  }

  action id {
    @body.id = Integer(data[mark..p].pack('c*'))
  }

  date = upper lower{2} ' ' digit{2} ',' ' ' digit{4};
  revised_on = ' '* 'Revised' ' '* ':' ' '* date >mark @revised_on;
  printable = alnum | [\/()];

  name = printable >mark (' '{1,2} | printable)* printable %name :>> space{3,};

  id = digit+ >mark @id;

  main := (
    any*
    revised_on ' '+ name :> id '\n'
    any*
  );
}%%
=end
require 'date'

module Tengai
  class BodyDataSheetParser
    attr_reader :data, :eof

    def initialize(data, body)
      @data = data.unpack('c*') if data.is_a? String
      @eof = @data.length
      @body = body
    end

    def parse
      %% write data;
      %% write init;
      %% write exec;
      @body
    end

    def self.parse(data, body = Tengai::Body.new)
      new(data, body).parse
    end
  end
end
