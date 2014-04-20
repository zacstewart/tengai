require 'spec_helper'

describe Body do
  describe '#find' do
    let(:client) { Client.new }

    context 'finding mars' do
      subject { Body.find(client, 499) }
      let(:body) { BodyDataSheetParser.parse(Fixtures.mars, Body.new) }

      its(:id) { should eq(499) }
      its(:name) { should eq('Mars') }

      it 'should equal the same body from a fixture' do
        expect(subject).to eq(body)
      end
    end

    context 'finding earth' do
      subject { Body.find(client, 399) }
      let(:body) { BodyDataSheetParser.parse(Fixtures.earth, Body.new) }

      its(:id) { should eq(399) }
      its(:name) { should eq('Earth') }

      it 'should equal the same body from a fixture' do
        expect(subject).to eq(body)
      end
    end
  end
end
