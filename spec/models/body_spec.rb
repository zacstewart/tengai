require 'fixtures'
require 'spec_helper'

describe Tengai::Body do
  let(:client) { double('Client', cmd: mars_data) }

  let(:mars_data) { Fixtures.mars }

  let(:parser) { double('Parser', parse: nil) }

  describe '#find' do
    it 'sends to body id as a telnet command' do
      expect(client).to receive(:cmd).
        with('String' => '499', 'Match' => /<cr>:\s*$/).
        and_return(mars_data)
      described_class.find(client, 499, parser)
    end

    it 'parses the data received from the client' do
      expect(parser).to receive(:parse).with(mars_data)
      described_class.find(client, 499, parser)
    end
  end

  describe '#==' do
    subject { Tengai::Body.new(id: 499, name: 'Mars', revised_on: Date.today) }
    let(:mars) { Tengai::Body.new(id: 499, name: 'Mars', revised_on: Date.today) }

    it { should == mars }
  end
end
