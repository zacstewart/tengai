require 'test_helper'

class VectorEphemerisParserTest < Test::Unit::TestCase
  def setup
    @ephemeris = Ephemeris.new(mock, Fixtures.vector_ephemeris)
  end

  def test_target_body_id
    @ephemeris.expects(:target_body_id=).with(499)
    VectorEphemerisParser.parse(Fixtures.vector_ephemeris, @ephemeris)
  end

  def test_center_body_id
    @ephemeris.expects(:center_body_id=).returns(399)
    VectorEphemerisParser.parse(Fixtures.vector_ephemeris, @ephemeris)
  end

  def test_start_time
    @ephemeris.expects(:start_time=).with(DateTime.parse('1900-01-04T00:00:00+00:00'))
    VectorEphemerisParser.parse(Fixtures.vector_ephemeris, @ephemeris)
  end

  def test_stop_time
    @ephemeris.expects(:stop_time=).with(DateTime.parse('2100-01-03T00:00:00+00:00'))
    VectorEphemerisParser.parse(Fixtures.vector_ephemeris, @ephemeris)
  end

  def test_step_size
    @ephemeris.expects(:step_size=).with('100 calendar years')
    VectorEphemerisParser.parse(Fixtures.vector_ephemeris, @ephemeris)
  end

  def test_ephemeris_table
    @ephemeris.expects(:ephemeris_table=).with(<<EOS
JDCT ,   , X, Y, Z, VX, VY, VZ, LT, RG, RR,
2415023.500000000, A.D. 1900-Jan-04 00:00:00.0000,  4.798942014821934E-01, -1.203536629131559E+00, -5.652327186621962E-01,  1.370915170660907E-02,  5.502275937589785E-03,  2.149502081087562E-03,  8.164317509179321E-03,  1.413607756247767E+00, -8.900751447771002E-04,
2451547.500000000, A.D. 2000-Jan-04 00:00:00.0000,  1.384794374160415E+00,  3.326800792581258E-02, -2.208505372473301E-02,  2.951762409660592E-04,  1.380219433765170E-02,  6.322854911310298E-03,  8.001229688088482E-03,  1.385369975369652E+00,  5.257002324522832E-04,
EOS
    )
    VectorEphemerisParser.parse(Fixtures.vector_ephemeris, @ephemeris)
  end
end
