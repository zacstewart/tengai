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

    ephemeris = Ephemeris.fetch(mock, @body)
    assert_equal Fixtures.ephemeris, ephemeris.data
  end
end
