require 'test/unit'
require 'fixtures'
require_relative '../../ext/horizons/body_data_sheet_parser'

class BodyDataSheetParserTest < Test::Unit::TestCase
  def setup
    @parsed_mars_data = Tengai::BodyDataSheetParser.parse(Fixtures.mars)
    @parsed_io_data = Tengai::BodyDataSheetParser.parse(Fixtures.io)
  end

  def test_revised_on
    assert_equal Date.new(2012, 9, 28), @parsed_mars_data[:revised_on]
    assert_equal Date.new(2004, 1, 8), @parsed_io_data[:revised_on]
  end

  def test_name
    assert_equal 'Mars', @parsed_mars_data[:name]
    assert_equal 'Io  / (Jupiter)', @parsed_io_data[:name]
  end

  def test_id
    assert_equal 499, @parsed_mars_data[:id]
    assert_equal 501, @parsed_io_data[:id]
  end
end
