require 'spec_helper'

describe Tengai::Ephemeris do
  describe '#fetch' do
    let(:client) { double('Client') }
    let(:body) { double('Body', id: 499) }
    let(:data_sheet) { double('Date sheet') }
    let(:parsed_data) { {
      target_body_id: 499,
      center_body_id: 0,
      start_time: DateTime.new(1900, 1, 4, 0, 0, 0),
      stop_time: DateTime.new(2100, 1, 3, 0, 0, 0),
      step_size: "100 calendar years",
      ephemeris_table: [
        { jdct: "2415023.500000000",
          x: "4.798942014821934E-01",
          y: "-1.203536629131559E+00",
          z: "-5.652327186621962E-01",
          vx: "1.370915170660907E-02",
          vy: "5.502275937589785E-03",
          vz: "2.149502081087562E-03",
          lt: "8.164317509179321E-03",
          rg: "1.413607756247767E+00",
          rr: "-8.900751447771002E-04" },
        { jdct: "2451547.500000000",
          x: "1.384794374160415E+00",
          y: "3.326800792581258E-02",
          z: "-2.208505372473301E-02",
          vx: "2.951762409660592E-04",
          vy: "1.380219433765170E-02",
          vz: "6.322854911310298E-03",
          lt: "8.001229688088482E-03",
          rg: "1.385369975369652E+00",
          rr: "5.257002324522832E-04" }
      ]
    } }
    let(:parser) { double('Parser') }
    let(:request) { double('Request') }
    let(:options) { {request: request, parser: parser} }

    before do
      allow(request).to receive(:fetch).and_return(data_sheet)
      allow(parser).to receive(:parse).with(data_sheet).and_return(parsed_data)
    end

    it 'makes a request' do
      expect(request).to receive(:fetch).and_return(data_sheet)
      described_class.fetch(client, body, options)
    end

    it 'parses the result of the request' do
      expect(parser).to receive(:parse).with(data_sheet).and_return(parsed_data)
      described_class.fetch(client, body, options)
    end

    it 'creates a new Ephemeris' do
      ephemeris = described_class.fetch(client, body, options)
      expect(ephemeris).to be_a(Tengai::Ephemeris)
      expect(ephemeris.target_body_id).to eq(499)
      expect(ephemeris.center_body_id).to eq(0)
      expect(ephemeris.start_time).to eq(DateTime.new(1900, 1, 4, 0, 0, 0))
      expect(ephemeris.stop_time).to eq(DateTime.new(2100, 1, 3, 0, 0, 0))
      expect(ephemeris.step_size).to eq('100 calendar years')
      expect(ephemeris.ephemeris_table).to have(2).items
    end
  end
end
