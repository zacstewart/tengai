require 'fixtures'

describe Tengai::VectorEphemerisParser do
  let(:table_parser) { double('Table Parser', parse: nil) }

  let(:data_sheet) { Fixtures.vector_ephemeris }

  let(:table_data) { <<-EOS }
JDCT ,   , X, Y, Z, VX, VY, VZ, LT, RG, RR,
2415023.500000000, A.D. 1900-Jan-04 00:00:00.0000,  4.798942014821934E-01, -1.203536629131559E+00, -5.652327186621962E-01,  1.370915170660907E-02,  5.502275937589785E-03,  2.149502081087562E-03,  8.164317509179321E-03,  1.413607756247767E+00, -8.900751447771002E-04,
2451547.500000000, A.D. 2000-Jan-04 00:00:00.0000,  1.384794374160415E+00,  3.326800792581258E-02, -2.208505372473301E-02,  2.951762409660592E-04,  1.380219433765170E-02,  6.322854911310298E-03,  8.001229688088482E-03,  1.385369975369652E+00,  5.257002324522832E-04,
EOS

  let(:table_hashes) { [
      {:jdct => '2415023.500000000', :x      => '4.798942014821934E-01',
       :y    => '-1.203536629131559E+00', :z => '-5.652327186621962E-01',
       :vx   => '1.370915170660907E-02', :vy => '5.502275937589785E-03',
       :vz   => '2.149502081087562E-03', :lt => '8.164317509179321E-03',
       :rg   => '1.413607756247767E+00', :rr => '-8.900751447771002E-04'},
      {:jdct => '2451547.500000000', :x      => '1.384794374160415E+00',
       :y    => '3.326800792581258E-02', :z  => '-2.208505372473301E-02',
       :vx   => '2.951762409660592E-04', :vy => '1.380219433765170E-02',
       :vz   => '6.322854911310298E-03', :lt => '8.001229688088482E-03',
       :rg   => '1.385369975369652E+00', :rr => '5.257002324522832E-04'} ] }

  describe '#parse' do
    subject { described_class.parse(data_sheet, table_parser) }

    it { expect(subject[:target_body_id]).to eq(499) }

    it { expect(subject[:center_body_id]).to eq(0) }

    it { expect(subject[:start_time]).to eq(DateTime.parse('1900-01-04T00:00:00+00:00')) }

    it { expect(subject[:stop_time]).to eq(DateTime.parse('2100-01-03T00:00:00+00:00')) }

    it { expect(subject[:step_size]).to eq('100 calendar years') }

    it 'parses the ephemeris table' do
      expect(table_parser).to receive(:parse).with(table_data).and_return(table_hashes)
      expect(subject[:ephemeris_table]).to eq(table_hashes)
    end
  end
end
