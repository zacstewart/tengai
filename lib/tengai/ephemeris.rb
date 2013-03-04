require 'tengai/requests/ephemeris_request'

module Tengai
  class Ephemeris
    attr_accessor :data, :target_body_id, :center_body_id, :start_time,
      :stop_time, :step_size, :ephemeris_columns, :ephemeris_table

    def initialize(client, data)
      @client = client
      @data = data
      VectorEphemerisParser.parse(@data, self)
    end

    def target_body
      @target_body ||= Tengai::Body.find(@client, target_body_id)
    end

    # Public: fetch an ephemeris table for a given body using the client
    #
    # client - Tengai::Client
    # body - a Tengai::Body instance whose ephemeris is needed
    # options - A Hash of options for refining the ephemeris table
    #           :start_time - The Time beginning of the ephemeris
    #           :stop_time - The Time end of the ephemeris
    def self.fetch(client, body, options={})
      start_time = options[:start_time] || Date.today.to_time # defaults start at today
      stop_time = options[:stop_time] || (Date.today + 1).to_time # and end tomorrow

      data = EphemerisRequest.fetch(
        client, body.id, start_time: start_time, stop_time: stop_time)

      new(client, data)
    end
  end
end
