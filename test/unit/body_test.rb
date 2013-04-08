require 'test/unit'
require 'mocha/setup'
require 'fixtures'
require_relative '../../lib/tengai/body'

class BodyTest < Test::Unit::TestCase
  def setup
    @client = mock('Client')
  end

  def test_find_sends_command_body_id
    client = mock
    client.expects(:cmd).
      with('String' => '499', 'Match' => /<cr>:\s*$/).
      returns(Fixtures.mars)

    Tengai::Body.find(client, 499, stub_everything)
  end

  def test_find_invokes_parser
    client = mock
    client.stubs(:cmd).
      with('String' => '499', 'Match' => /<cr>:\s*$/).
      returns(Fixtures.mars)
    parser = mock
    parser.expects(:parse).with(Fixtures.mars)
    Tengai::Body.find(client, 499, parser)
  end

  def test_equality
    mars_one = Tengai::Body.new(id: 499, name: 'Mars', revised_on: Date.today)
    mars_two = Tengai::Body.new(id: 499, name: 'Mars', revised_on: Date.today)
    assert_equal mars_one, mars_two
  end
end
