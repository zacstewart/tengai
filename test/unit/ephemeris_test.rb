require 'test_helper'

class EphemerisTest < Test::Unit::TestCase
  def setup
    @body = Body.new(File.read('test/fixtures/bodies/499.txt'))
  end

  def test_fetch_should_get_data_from_an_ephemeris_request
    @ephemeris_request = mock
    @ephemeris_request.expects(:fetch).returns(@ephemeris_request)
    @ephemeris_request.expects(:data).returns(Fixtures.ephemeris)
    EphemerisRequest.stubs(:new).returns(@ephemeris_request)

    @ephemeris_parser = mock
    @ephemeris_parser.expects(:start_time).returns(DateTime.parse('2012-12-28T00:01:00+00:00'))
    @ephemeris_parser.expects(:stop_time).returns(DateTime.parse('2012-12-29T00:01:00+00:00'))
    EphemerisParser.stubs(:parse).returns(@ephemeris_parser)

    ephemeris = Ephemeris.fetch(mock, @body)

    assert_equal DateTime.parse('2012-12-28T00:01:00+00:00'), ephemeris.start_time
    assert_equal DateTime.parse('2012-12-29T00:01:00+00:00'), ephemeris.stop_time
  end
end
