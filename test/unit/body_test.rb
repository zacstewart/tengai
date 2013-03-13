require 'test/unit'
require 'mocha/setup'
require_relative '../../lib/tengai/body'

class BodyTest < Test::Unit::TestCase
  def setup
    @client = mock
    @mars  = Tengai::Body.new(File.read('test/fixtures/bodies/499.txt'))
    @earth = Tengai::Body.new(File.read('test/fixtures/bodies/399.txt'))
    @sun   = Tengai::Body.new(File.read('test/fixtures/bodies/10.txt'))
    @io    = Tengai::Body.new(File.read('test/fixtures/bodies/501.txt'))
  end

  # revised_on

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

  # name

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

  # id

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
    data_sheet = File.read('test/fixtures/bodies/499.txt')

    @client.expects(:cmd).
      with('String' => '499', 'Match' => /<cr>:\s*$/).
      returns(data_sheet)
    Tengai::Body.expects(:new).with(data_sheet)

    @body = Tengai::Body.find(@client, '499')
  end

  def test_body_comparison
    other_mars = Tengai::Body.new(File.read('test/fixtures/bodies/499.txt'))
    assert_equal @mars, other_mars
  end
end
