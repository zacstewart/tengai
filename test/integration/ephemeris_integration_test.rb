require 'test_helper'

class EphemerisIntegrationTest < Test::Unit::TestCase
  def setup
    @client = Client.new
    @mars = Body.find(@client, 499)

    # Limit delta, otherwise the system can take a long time to generate an
    # ephemeris.
    @start_time = Forgery::Date.date(max_delta: 3).to_datetime
    @stop_time = @start_time + 1 + rand(2)

    @ephemeris = Ephemeris.fetch(
      @client, @mars, start_time: @start_time, stop_time: @stop_time)
  end

  def test_target_body_id
    assert_equal @mars, @ephemeris.target_body
  end

  def test_start_time
    assert_equal @start_time, @ephemeris.start_time
  end

  def test_stop_time
    assert_equal @stop_time, @ephemeris.stop_time
  end

  def teardown
    @client.disconnect
  end
end
