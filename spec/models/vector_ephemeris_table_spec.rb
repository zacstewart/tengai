require 'spec_helper'

describe Tengai::VectorEphemerisTable do

  describe '::new_with_table' do
    let(:row_hash) { {
      jdct: '2415023.500000000',
      x: '4.798942014821934E-01',
      y: '-1.203536629131559E+00',
      z: '-5.652327186621962E-01',
      vx: '1.370915170660907E-02',
      vy: '5.502275937589785E-03',
      vz: '2.149502081087562E-03',
      lt: '8.164317509179321E-03',
      rg: '1.413607756247767E+00',
      rr: '-8.900751447771002E-04' } }

    let(:row) { double('Row') }

    subject { described_class.new_with_table([row_hash]).first }

    it { expect(subject.jdct).to eq(DateTime.jd(2415023.500000000)) }
    it { expect(subject.x).to eq(0.4798942014821934) }
    it { expect(subject.y).to eq(-1.203536629131559) }
    it { expect(subject.z).to eq(-0.5652327186621962) }
    it { expect(subject.vx).to eq(0.01370915170660907) }
    it { expect(subject.vy).to eq(0.005502275937589785) }
    it { expect(subject.vz).to eq(0.002149502081087562) }
    it { expect(subject.lt).to eq(0.008164317509179321) }
    it { expect(subject.rg).to eq(1.413607756247767) }
    it { expect(subject.rr).to eq(-0.0008900751447771002) }
  end
end
