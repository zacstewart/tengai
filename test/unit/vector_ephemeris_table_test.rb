require 'test/unit'
require 'mocha/setup'
require_relative '../../lib/tengai/vector_ephemeris_table'

class VectorEphemerisTableTest < Test::Unit::TestCase
  def setup
    @table = <<-EOS
JDCT ,   , X, Y, Z, VX, VY, VZ, LT, RG, RR,
2415023.500000000, A.D. 1900-Jan-04 00:00:00.0000,  4.798942014821934E-01, -1.203536629131559E+00, -5.652327186621962E-01,  1.370915170660907E-02,  5.502275937589785E-03,  2.149502081087562E-03,  8.164317509179321E-03,  1.413607756247767E+00, -8.900751447771002E-04,
    EOS
  end

  def test_new_with_table
    row = mock('Row')
    hash = {
      jdct: '2415023.500000000',
      x: '4.798942014821934E-01',
      y: '-1.203536629131559E+00',
      z: '-5.652327186621962E-01',
      vx: '1.370915170660907E-02',
      vy: '5.502275937589785E-03',
      vz: '2.149502081087562E-03',
      lt: '8.164317509179321E-03',
      rg: '1.413607756247767E+00',
      rr: '-8.900751447771002E-04'}
    Tengai::VectorEphemerisTable::Row.expects(:new).with(hash).returns(row)
    Tengai::VectorEphemerisTable.expects(:new).with([row])
    Tengai::VectorEphemerisTable.new_with_table([hash])
  end
end
