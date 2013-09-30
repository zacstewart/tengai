require 'fixtures'
require 'spec_helper'

describe Tengai::BodyDataSheetParser do
  describe '::parse' do
    subject { described_class.parse(data_sheet) }

    context "parsing Mars' data sheet" do
      let(:data_sheet) { Fixtures.mars }

      it { expect(subject[:revised_on]).to eq(Date.new(2012, 9, 28)) }

      it { expect(subject[:name]).to eq('Mars') }

      it { expect(subject[:id]).to eq(499) }
    end

    context "parsing Mars' data sheet" do
      let(:data_sheet) { Fixtures.io }

      it { expect(subject[:revised_on]).to eq(Date.new(2004, 1, 8)) }

      it { expect(subject[:name]).to eq('Io  / (Jupiter)') }

      it { expect(subject[:id]).to eq(501) }
    end
  end
end
