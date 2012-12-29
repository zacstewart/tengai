require 'test_helper'

class BodyIntegratoinTest < Test::Unit::TestCase
  def setup
    @client = Client.new
  end

  def test_find_mars
    body = Body.find(@client, 499)
    assert_equal 499, body.id
    assert_equal 'Mars', body.name
    assert_equal Body.new(Fixtures.mars), body
  end

  def test_find_earth
    body = Body.find(@client, 399)
    assert_equal 399, body.id
    assert_equal 'Earth', body.name
    assert_equal Body.new(Fixtures.earth), body
  end
end
