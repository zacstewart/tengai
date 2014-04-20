$:.unshift File.dirname(File.dirname(__FILE__))
require 'tengai/requests/telnet_ephemeris_request'
require 'tengai/vector_ephemeris_table'

module Tengai
  class Ephemeris
    attr_accessor :target_body_id, :center_body_id, :start_time, :stop_time,
      :step_size, :ephemeris_table

    def initialize(client, data)
      @client = client
      self.target_body_id = data.fetch(:target_body_id)
      self.center_body_id = data.fetch(:center_body_id)
      self.start_time = data.fetch(:start_time)
      self.stop_time = data.fetch(:stop_time)
      self.step_size = data.fetch(:step_size)
      self.ephemeris_table = data.fetch(:ephemeris_table)
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

      # Inject dependencies
      parser = options[:parser] || VectorEphemerisParser
      request = options[:request] || TelnetEphemerisRequest

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
