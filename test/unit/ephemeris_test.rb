require 'test/unit'
require 'mocha/setup'
require_relative '../../lib/tengai/ephemeris'

class EphemerisTest < Test::Unit::TestCase
  def test_fetch_should_get_data_from_an_ephemeris_request
    client = mock('Client')
    body = mock('Body', id: 499)
    data_sheet = File.read('test/fixtures/ephemerides/mars_vectors_from_solar_system_center.txt')
    data_hash = mock('Hash')
    request_factory = mock('EphemerisRequest')
    vector_ephemeris_parser = mock('VectorEphemerisParser')
    options = {request: request_factory, parser: vector_ephemeris_parser}

    request_factory.expects(:fetch).returns(data_sheet)
    vector_ephemeris_parser.expects(:parse).with(data_sheet).returns(data_hash)

    Tengai::Ephemeris.expects(:new).with(client, data_hash)

    Tengai::Ephemeris.fetch(client, body, options)
  end
end
