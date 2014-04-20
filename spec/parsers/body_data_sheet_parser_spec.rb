require 'fixtures'
require 'spec_helper'

describe Tengai::BodyDataSheetParser do
  describe '::parse' do
    let(:body) { double('Body') }

    before do
      allow(body).to receive(:revised_on=)
      allow(body).to receive(:name=)
      allow(body).to receive(:id=)
    end

    context "parsing Mars' data sheet" do
      let(:data_sheet) { Fixtures.mars }

      it 'sets revised_on' do
        expect(body).to receive(:revised_on=).with(Date.new(2012, 9, 28))
        described_class.parse(data_sheet, body)
      end

      it 'sets name' do
        expect(body).to receive(:name=).with('Mars')
        described_class.parse(data_sheet, body)
      end

      it 'sets id' do
        expect(body).to receive(:id=).with(499)
        described_class.parse(data_sheet, body)
      end

    end

    context "parsing Io's data sheet" do
      let(:data_sheet) { Fixtures.io }

      it 'sets revised_on' do
        expect(body).to receive(:revised_on=).with(Date.new(2004, 1, 8))
        described_class.parse(data_sheet, body)
      end

      it 'sets name' do
        expect(body).to receive(:name=).with('Io  / (Jupiter)')
        described_class.parse(data_sheet, body)
      end

      it 'sets id' do
        expect(body).to receive(:id=).with(501)
        described_class.parse(data_sheet, body)
      end
    end
  end
end
