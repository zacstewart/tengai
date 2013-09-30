require 'spec_helper'

describe Tengai::Ephemeris do
  describe '#fetch' do
    let(:client) { double('Client') }
    let(:body) { double('Body', id: 499) }
    let(:data_sheet) { double('Date sheet') }
    let(:data_hash) { double('Data hash') }
    let(:parser) { double('Parser') }
    let(:request) { double('Request') }
    let(:options) { {request: request, parser: parser} }

    it 'makes a request, parses the result and creates a new Ephemeris' do
      expect(request).to receive(:fetch).and_return(data_sheet)
      expect(parser).to receive(:parse).with(data_sheet).and_return(data_hash)
      expect(described_class).to receive(:new).with(client, data_hash)
      described_class.fetch(client, body, options)
    end
  end
end
