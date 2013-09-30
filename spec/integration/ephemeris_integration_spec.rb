require 'spec_helper'

describe Ephemeris do
  describe '::fetch' do
    let(:client) { Client.new }
    let!(:body) { Body.find(client, 499) }
    let(:start_time) { Forgery::Date.date(max_delta: 3).to_datetime }
    let(:stop_time) { start_time + 1 + rand(2) }

    subject { Ephemeris.fetch(client, body, start_time: start_time, stop_time: stop_time) }

    its(:target_body) { should eq(body) }
    its(:start_time) { should eq(start_time) }
    its(:stop_time) { should eq(stop_time) }
    its(:ephemeris_table) { should be_any }
  end
end
