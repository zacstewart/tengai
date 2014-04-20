require 'fixtures'
require 'spec_helper'

describe Tengai::Body do
  let(:client) { double('Client', cmd: mars_data) }

  let(:mars_data) { Fixtures.mars }

  let(:parsed_data) { {
    revised_on: 'Sep 28, 2012',
    name: 'Mars',
    id: '499'
  } }

  let(:parser) { double('Parser', parse: nil) }

  describe '#find' do
    before do
      allow(client).to receive(:cmd).and_return(mars_data)
      allow(parser).to receive(:parse).and_return(parsed_data)
    end

    it 'sends to body id as a telnet command' do
      expect(client).to receive(:cmd).
        with('String' => '499', 'Match' => /<cr>:\s*$/).
        and_return(mars_data)
      described_class.find(client, 499, parser)
    end

    it 'parses the data received from the client' do
      expect(parser).to receive(:parse).with(mars_data).and_return(parsed_data)
      described_class.find(client, 499, parser)
    end

    it 'creates a new Body using the parsed data' do
      body = described_class.find(client, 499, parser)
      expect(body).to be_a(Tengai::Body)
      expect(body.revised_on).to eq(Date.new(2012, 9, 28))
      expect(body.name).to eq('Mars')
      expect(body.id).to eq(499)
    end
  end

  describe '#==' do
    subject { Tengai::Body.new(id: 499, name: 'Mars', revised_on: Date.today) }
    let(:mars) { Tengai::Body.new(id: 499, name: 'Mars', revised_on: Date.today) }

    it { should == mars }
  end
end
