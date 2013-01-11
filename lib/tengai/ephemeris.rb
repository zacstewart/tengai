require 'tengai/requests/ephemeris_request'

module Tengai
  class Ephemeris
    attr_reader :data

    def initialize(data)
      @data = EphemerisParser.parse(data)
    end

    def start_time
      @data.start_time
    end

    def stop_time
      @data.stop_time
    end

    # Public: fetch an ephemeris table for a given body using the client
    #
    # client - Tengai::Client
    # body - a Tengai::Body instance whose ephemeris is needed
    # options - A Hash of options for refining the ephemeris table
    #           :start_time - The Time beginning of the ephemeris
    #           :end_time - The Time end of the ephemeris
    def self.fetch(client, body, options={})
      start_time = options[:start_time] || Date.today.to_time # defaults start at today
      end_time = options[:end_time] || (Date.today + 1).to_time # and end tomorrow

      request = EphemerisRequest.new(
        client, body.id, start_time: start_time, end_time: end_time)

      new(request.fetch.data)
    end
  end
end
