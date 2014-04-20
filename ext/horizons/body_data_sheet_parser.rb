
# line 1 "ext/horizons/body_data_sheet_parser.rl"
=begin

# line 32 "ext/horizons/body_data_sheet_parser.rl"

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
      
# line 23 "ext/horizons/body_data_sheet_parser.rb"
class << self
	attr_accessor :_body_data_sheet_parser_actions
	private :_body_data_sheet_parser_actions, :_body_data_sheet_parser_actions=
end
self._body_data_sheet_parser_actions = [
	0, 1, 0, 1, 1, 1, 2, 1, 
	3, 2, 0, 3
]

class << self
	attr_accessor :_body_data_sheet_parser_key_offsets
	private :_body_data_sheet_parser_key_offsets, :_body_data_sheet_parser_key_offsets=
end
self._body_data_sheet_parser_key_offsets = [
	0, 0, 1, 3, 5, 7, 9, 11, 
	13, 16, 20, 23, 26, 28, 31, 34, 
	36, 38, 41, 44, 47, 50, 52, 62, 
	72, 84, 88, 92, 98, 101, 113, 125, 
	138, 151, 164, 177, 190, 203, 216, 229, 
	242, 249, 260, 264, 268, 271
]

class << self
	attr_accessor :_body_data_sheet_parser_trans_keys
	private :_body_data_sheet_parser_trans_keys, :_body_data_sheet_parser_trans_keys=
end
self._body_data_sheet_parser_trans_keys = [
	82, 82, 101, 82, 118, 82, 105, 82, 
	115, 82, 101, 82, 100, 32, 58, 82, 
	32, 82, 65, 90, 82, 97, 122, 82, 
	97, 122, 32, 82, 82, 48, 57, 82, 
	48, 57, 44, 82, 32, 82, 82, 48, 
	57, 82, 48, 57, 82, 48, 57, 82, 
	48, 57, 32, 82, 32, 82, 40, 41, 
	47, 57, 65, 90, 97, 122, 32, 82, 
	40, 41, 47, 57, 65, 90, 97, 122, 
	32, 82, 9, 13, 40, 41, 47, 57, 
	65, 90, 97, 122, 32, 82, 9, 13, 
	32, 82, 9, 13, 32, 82, 9, 13, 
	48, 57, 10, 48, 57, 32, 82, 9, 
	13, 40, 41, 47, 57, 65, 90, 97, 
	122, 32, 82, 9, 13, 40, 41, 47, 
	57, 65, 90, 97, 122, 32, 82, 101, 
	9, 13, 40, 41, 47, 57, 65, 90, 
	97, 122, 32, 82, 118, 9, 13, 40, 
	41, 47, 57, 65, 90, 97, 122, 32, 
	82, 105, 9, 13, 40, 41, 47, 57, 
	65, 90, 97, 122, 32, 82, 115, 9, 
	13, 40, 41, 47, 57, 65, 90, 97, 
	122, 32, 82, 101, 9, 13, 40, 41, 
	47, 57, 65, 90, 97, 122, 32, 82, 
	100, 9, 13, 40, 41, 47, 57, 65, 
	90, 97, 122, 32, 58, 82, 9, 13, 
	40, 41, 47, 57, 65, 90, 97, 122, 
	32, 58, 82, 9, 13, 40, 41, 47, 
	57, 65, 90, 97, 122, 32, 58, 82, 
	9, 13, 40, 41, 47, 57, 65, 90, 
	97, 122, 32, 58, 82, 9, 13, 48, 
	57, 32, 82, 101, 40, 41, 47, 57, 
	65, 90, 97, 122, 82, 101, 97, 122, 
	82, 118, 97, 122, 32, 82, 105, 0
]

class << self
	attr_accessor :_body_data_sheet_parser_single_lengths
	private :_body_data_sheet_parser_single_lengths, :_body_data_sheet_parser_single_lengths=
end
self._body_data_sheet_parser_single_lengths = [
	0, 1, 2, 2, 2, 2, 2, 2, 
	3, 2, 1, 1, 2, 1, 1, 2, 
	2, 1, 1, 1, 1, 2, 2, 2, 
	2, 2, 2, 2, 1, 2, 2, 3, 
	3, 3, 3, 3, 3, 3, 3, 3, 
	3, 3, 2, 2, 3, 0
]

class << self
	attr_accessor :_body_data_sheet_parser_range_lengths
	private :_body_data_sheet_parser_range_lengths, :_body_data_sheet_parser_range_lengths=
end
self._body_data_sheet_parser_range_lengths = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 1, 1, 1, 0, 1, 1, 0, 
	0, 1, 1, 1, 1, 0, 4, 4, 
	5, 1, 1, 2, 1, 5, 5, 5, 
	5, 5, 5, 5, 5, 5, 5, 5, 
	2, 4, 1, 1, 0, 0
]

class << self
	attr_accessor :_body_data_sheet_parser_index_offsets
	private :_body_data_sheet_parser_index_offsets, :_body_data_sheet_parser_index_offsets=
end
self._body_data_sheet_parser_index_offsets = [
	0, 0, 2, 5, 8, 11, 14, 17, 
	20, 24, 28, 31, 34, 37, 40, 43, 
	46, 49, 52, 55, 58, 61, 64, 71, 
	78, 86, 90, 94, 99, 102, 110, 118, 
	127, 136, 145, 154, 163, 172, 181, 190, 
	199, 205, 213, 217, 221, 225
]

class << self
	attr_accessor :_body_data_sheet_parser_indicies
	private :_body_data_sheet_parser_indicies, :_body_data_sheet_parser_indicies=
end
self._body_data_sheet_parser_indicies = [
	1, 0, 1, 2, 0, 1, 3, 0, 
	1, 4, 0, 1, 5, 0, 1, 6, 
	0, 1, 7, 0, 7, 8, 1, 0, 
	8, 10, 9, 0, 1, 11, 0, 1, 
	12, 0, 13, 1, 0, 1, 14, 0, 
	1, 15, 0, 16, 1, 0, 17, 1, 
	0, 1, 18, 0, 1, 19, 0, 1, 
	20, 0, 1, 21, 0, 22, 1, 0, 
	22, 24, 23, 23, 23, 23, 0, 25, 
	27, 26, 26, 26, 26, 0, 29, 27, 
	28, 26, 26, 26, 26, 0, 30, 1, 
	30, 0, 31, 1, 31, 0, 31, 1, 
	31, 32, 0, 33, 35, 34, 36, 27, 
	30, 26, 26, 26, 26, 0, 31, 27, 
	31, 26, 26, 26, 26, 0, 29, 27, 
	37, 28, 26, 26, 26, 26, 0, 29, 
	27, 38, 28, 26, 26, 26, 26, 0, 
	29, 27, 39, 28, 26, 26, 26, 26, 
	0, 29, 27, 40, 28, 26, 26, 26, 
	26, 0, 29, 27, 41, 28, 26, 26, 
	26, 26, 0, 29, 27, 42, 28, 26, 
	26, 26, 26, 0, 43, 8, 27, 28, 
	26, 26, 26, 26, 0, 44, 8, 27, 
	30, 26, 26, 26, 26, 0, 45, 8, 
	27, 31, 26, 26, 26, 26, 0, 45, 
	8, 1, 31, 32, 0, 25, 27, 37, 
	26, 26, 26, 26, 0, 1, 46, 11, 
	0, 1, 47, 12, 0, 13, 1, 4, 
	0, 33, 0
]

class << self
	attr_accessor :_body_data_sheet_parser_trans_targs
	private :_body_data_sheet_parser_trans_targs, :_body_data_sheet_parser_trans_targs=
end
self._body_data_sheet_parser_trans_targs = [
	1, 2, 3, 4, 5, 6, 7, 8, 
	9, 10, 42, 11, 12, 13, 14, 15, 
	16, 17, 18, 19, 20, 21, 22, 23, 
	41, 23, 24, 31, 25, 29, 26, 27, 
	28, 45, 0, 28, 30, 32, 33, 34, 
	35, 36, 37, 38, 39, 40, 43, 44
]

class << self
	attr_accessor :_body_data_sheet_parser_trans_actions
	private :_body_data_sheet_parser_trans_actions, :_body_data_sheet_parser_trans_actions=
end
self._body_data_sheet_parser_trans_actions = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 1, 1, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 3, 0, 1, 
	1, 0, 0, 0, 5, 5, 0, 0, 
	9, 0, 0, 7, 0, 0, 0, 0, 
	0, 0, 0, 5, 0, 0, 0, 0
]

class << self
	attr_accessor :body_data_sheet_parser_start
end
self.body_data_sheet_parser_start = 1;
class << self
	attr_accessor :body_data_sheet_parser_first_final
end
self.body_data_sheet_parser_first_final = 45;
class << self
	attr_accessor :body_data_sheet_parser_error
end
self.body_data_sheet_parser_error = 0;

class << self
	attr_accessor :body_data_sheet_parser_en_main
end
self.body_data_sheet_parser_en_main = 1;


# line 48 "ext/horizons/body_data_sheet_parser.rl"
      
# line 209 "ext/horizons/body_data_sheet_parser.rb"
begin
	p ||= 0
	pe ||= data.length
	cs = body_data_sheet_parser_start
end

# line 49 "ext/horizons/body_data_sheet_parser.rl"
      
# line 218 "ext/horizons/body_data_sheet_parser.rb"
begin
	_klen, _trans, _keys, _acts, _nacts = nil
	_goto_level = 0
	_resume = 10
	_eof_trans = 15
	_again = 20
	_test_eof = 30
	_out = 40
	while true
	_trigger_goto = false
	if _goto_level <= 0
	if p == pe
		_goto_level = _test_eof
		next
	end
	if cs == 0
		_goto_level = _out
		next
	end
	end
	if _goto_level <= _resume
	_keys = _body_data_sheet_parser_key_offsets[cs]
	_trans = _body_data_sheet_parser_index_offsets[cs]
	_klen = _body_data_sheet_parser_single_lengths[cs]
	_break_match = false
	
	begin
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + _klen - 1

	     loop do
	        break if _upper < _lower
	        _mid = _lower + ( (_upper - _lower) >> 1 )

	        if data[p].ord < _body_data_sheet_parser_trans_keys[_mid]
	           _upper = _mid - 1
	        elsif data[p].ord > _body_data_sheet_parser_trans_keys[_mid]
	           _lower = _mid + 1
	        else
	           _trans += (_mid - _keys)
	           _break_match = true
	           break
	        end
	     end # loop
	     break if _break_match
	     _keys += _klen
	     _trans += _klen
	  end
	  _klen = _body_data_sheet_parser_range_lengths[cs]
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + (_klen << 1) - 2
	     loop do
	        break if _upper < _lower
	        _mid = _lower + (((_upper-_lower) >> 1) & ~1)
	        if data[p].ord < _body_data_sheet_parser_trans_keys[_mid]
	          _upper = _mid - 2
	        elsif data[p].ord > _body_data_sheet_parser_trans_keys[_mid+1]
	          _lower = _mid + 2
	        else
	          _trans += ((_mid - _keys) >> 1)
	          _break_match = true
	          break
	        end
	     end # loop
	     break if _break_match
	     _trans += _klen
	  end
	end while false
	_trans = _body_data_sheet_parser_indicies[_trans]
	cs = _body_data_sheet_parser_trans_targs[_trans]
	if _body_data_sheet_parser_trans_actions[_trans] != 0
		_acts = _body_data_sheet_parser_trans_actions[_trans]
		_nacts = _body_data_sheet_parser_actions[_acts]
		_acts += 1
		while _nacts > 0
			_nacts -= 1
			_acts += 1
			case _body_data_sheet_parser_actions[_acts - 1]
when 0 then
# line 5 "ext/horizons/body_data_sheet_parser.rl"
		begin
 mark = p 		end
when 1 then
# line 7 "ext/horizons/body_data_sheet_parser.rl"
		begin

    @body.revised_on = Date.parse(data[mark..p].pack('c*'))
  		end
when 2 then
# line 11 "ext/horizons/body_data_sheet_parser.rl"
		begin

    @body.name = data[mark..p - 1].pack('c*')
  		end
when 3 then
# line 15 "ext/horizons/body_data_sheet_parser.rl"
		begin

    @body.id = Integer(data[mark..p].pack('c*'))
  		end
# line 321 "ext/horizons/body_data_sheet_parser.rb"
			end # action switch
		end
	end
	if _trigger_goto
		next
	end
	end
	if _goto_level <= _again
	if cs == 0
		_goto_level = _out
		next
	end
	p += 1
	if p != pe
		_goto_level = _resume
		next
	end
	end
	if _goto_level <= _test_eof
	end
	if _goto_level <= _out
		break
	end
	end
	end

# line 50 "ext/horizons/body_data_sheet_parser.rl"
      @body
    end

    def self.parse(data, body = Tengai::Body.new)
      new(data, body).parse
    end
  end
end
