require 'test_helper'

class BodyTest < Test::Unit::TestCase
  def setup
    @client = mock
    @mars  = Body.new(File.read('test/fixtures/bodies/499.txt'))
    @earth = Body.new(File.read('test/fixtures/bodies/399.txt'))
    @sun   = Body.new(File.read('test/fixtures/bodies/10.txt'))
    @io    = Body.new(File.read('test/fixtures/bodies/501.txt'))
  end

  def test_mars_revised_on
    assert_equal @mars.revised_on, Date.new(2012, 9, 28)
  end

  def test_earth_revised_on
    assert_equal Date.new(2003, 4, 3), @earth.revised_on
  end

  def test_sun_revised_on
    assert_equal Date.new(1996, 9, 12), @sun.revised_on
  end

  def test_io_revised_on
    assert_equal Date.new(2004, 1, 8), @io.revised_on
  end

  def test_mars_name
    assert_equal 'Mars', @mars.name
  end

  def test_earth_name
    assert_equal 'Earth', @earth.name
  end

  def test_sun_name
    assert_equal 'Sun', @sun.name
  end

  def test_io_name
    assert_equal 'Io  / (Jupiter)', @io.name
  end

  def test_mars_id
    assert_equal 499, @mars.id
  end

  def test_earth_id
    assert_equal 399, @earth.id
  end

  def test_sun_id
    assert_equal 10, @sun.id
  end

  def test_io_id
    assert_equal 501, @io.id
  end

  def test_find
    @client.expects(:cmd).
      with('String' => '499', 'Match' => /<cr>:\s*$/).
      returns(File.read('test/fixtures/bodies/499.txt'))

    @body = Body.find(@client, '499')
    assert_equal @mars, @body
  end
end
