require 'test_helper'

class BodyIntegrationTest < Test::Unit::TestCase
  def setup
    @client = Client.new
  end

  def test_find_mars
    body = Body.find(@client, 499)
    assert_equal 499, body.id
    assert_equal 'Mars', body.name
    assert_equal Body.new(BodyDataSheetParser.parse(Fixtures.mars)), body
  end

  def test_find_earth
    body = Body.find(@client, 399)
    assert_equal 399, body.id
    assert_equal 'Earth', body.name
    assert_equal Body.new(BodyDataSheetParser.parse(Fixtures.earth)), body
  end

  def teardown
    @client.disconnect
  end
end
