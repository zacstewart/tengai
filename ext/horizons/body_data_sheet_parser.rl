=begin
%%{
  machine body_data_sheet_parser;

  action mark { mark = p }

  action revised_on {
    _revised_on = data[mark..p].pack('c*')
  }

  action name {
    _name = data[mark..p - 1].pack('c*')
  }

  action id {
    _id = data[mark..p].pack('c*')
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
    def self.parse(data)
      data = data.unpack('c*') if data.is_a? String
      eof = data.length

      %% write init;
      %% write exec;

      { revised_on:  Date.parse(_revised_on),
        name:        _name,
        id:          _id.to_i }
    end

    %% write data;
  end
end
