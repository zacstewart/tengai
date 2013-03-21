$:.unshift File.dirname(File.dirname(__FILE__))
require 'tengai/requests/ephemeris_request'
require 'tengai/vector_ephemeris_table'

module Tengai
  class Ephemeris
    include Virtus
    attribute :target_body_id, Integer
    attribute :center_body_id, Integer
    attribute :start_time, DateTime
    attribute :stop_time, DateTime
    attribute :step_size, Integer
    attribute :ephemeris_table, VectorEphemerisTable

    def initialize(client, data)
      super(data)
      @client = client
    end

    def target_body
      @target_body ||= Tengai::Body.find(@client, target_body_id)
    end

    def ephemeris_table=(table)
      @ephemeris_table = VectorEphemerisTable.new_with_table(table)
    end

    # Public: fetch an ephemeris table for a given body using the client
    #
    # client - Tengai::Client
    # body - a Tengai::Body instance whose ephemeris is needed
    # options - A Hash of options for refining the ephemeris table
    #           :start_time - The Time beginning of the ephemeris
    #           :stop_time - The Time end of the ephemeris
    #           :interval - The resolution of the table in minutes
    def self.fetch(client, body, options={})
      start_time = options[:start_time] || Date.today.to_time # defaults start at today
      stop_time = options[:stop_time] || (Date.today + 1).to_time # and end tomorrow
      interval = options[:interval] || 1440
      request = options[:request] || EphemerisRequest
      parser = options[:parser] || VectorEphemerisParser

      data = request.fetch(
        client, body.id,
        start_time: start_time,
        stop_time: stop_time,
        interval: interval)
      data = parser.parse(data)

      new(client, data)
    end
  end
end
