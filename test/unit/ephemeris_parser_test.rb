require 'test_helper'

class EphemerisParserTest < Test::Unit::TestCase
  def setup
    @parser = EphemerisParser.parse(Fixtures.ephemeris)
  end

  def test_target_body_id
    assert_equal 499, @parser.target_body_id
  end

  def test_center_body_id
    assert_equal 399, @parser.center_body_id
  end

  def test_start_time
    assert_equal DateTime.parse('2012-12-28T00:01:00+00:00'), @parser.start_time
  end

  def test_stop_time
    assert_equal DateTime.parse('2012-12-29T00:01:00+00:00'), @parser.stop_time
  end

  def test_step_size
    assert_equal '1440 minutes', @parser.step_size
  end

  def test_ephemeris_table
    ephemeris_table = <<-EOE
2012-Dec-28 00:01     20 15 28.33 -20 59 03.0 20 16 13.39 -20 56 33.7 114.5645  26.39507 88659.56 8373.593  89.873   1.20   4.03 97.719   0.0964 89680.00/* 4.227254 263.01 -15.34 245.51 -20.28 259.62      0.63   8.5163     -2.03 318.7304  -1.8485 1.386867237136  -0.6735610 2.21545698067110   4.1643710  18.425394 26.40227 52.63836  24.9111 /T  17.3773  150.1/ 99.8 137.7116    n.a.    n.a.      n.a.  Cap    67.183820 301.5412284  -1.1577331 317.66765   52.87859  22.140535 -27.460132
2012-Dec-29 00:01     20 18 44.52 -20 48 25.5 20 19 29.49 -20 45 53.2 114.4932  26.97697 87736.60 8816.216  89.457   1.19   4.03 97.759   0.0946 88836.33/* 4.222678 253.14 -15.63 235.75 -20.45 259.37      0.62   8.0256     -2.02 319.3607  -1.8487 1.386485087387  -0.6497935 2.21785797146913   4.1498974  18.445362 26.40894 52.72181  24.6768 /T  17.2236  160.9/ 99.6 138.0996    n.a.    n.a.      n.a.  Cap    67.183848 302.3254149  -1.1562684 317.66765   52.87859  22.630560 -28.113325
    EOE
    assert_equal ephemeris_table, @parser.ephemeris_table
  end
end
