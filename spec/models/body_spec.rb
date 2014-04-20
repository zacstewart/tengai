require 'fixtures'
require 'spec_helper'

describe Tengai::Body do
  let(:body) { double('Body') }

  let(:client) { double('Client', cmd: mars_data) }

  let(:mars_data) { Fixtures.mars }

  let(:parsed_data) { {
    revised_on: Date.new(2012, 9, 28),
    name: 'Mars',
    id: 499
  } }

  let(:parser) { double('Parser', parse: nil) }

  describe '#find' do
    before do
      allow(client).to receive(:cmd).and_return(mars_data)
      allow(parser).to receive(:parse).and_return(body)
    end

    it 'sends to body id as a telnet command' do
      expect(client).to receive(:cmd).
        with('String' => '499', 'Match' => /<cr>:\s*$/).
        and_return(mars_data)
      described_class.find(client, 499, parser)
    end

    it 'parses the data received from the client' do
      allow(described_class).to receive(:new).and_return(body)
      expect(parser).to receive(:parse).with(mars_data, body)
      described_class.find(client, 499, parser)
    end
  end

  describe '#==' do
    subject { Tengai::Body.new(id: 499, name: 'Mars', revised_on: Date.today) }
    let(:mars) { Tengai::Body.new(id: 499, name: 'Mars', revised_on: Date.today) }

    it { should == mars }
  end
end
