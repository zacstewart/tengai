require 'test_helper'

class EphemerisParserTest < Test::Unit::TestCase
  def setup
    @parser = EphemerisParser.parse(Fixtures.ephemeris)
  end

  def test_start_time
    assert_equal DateTime.parse('2012-12-28T00:01:00+00:00'), @parser.start_time
  end

  def test_stop_time
    assert_equal DateTime.parse('2012-12-29T00:01:00+00:00'), @parser.stop_time
  end
end
