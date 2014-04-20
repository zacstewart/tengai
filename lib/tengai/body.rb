$:.unshift File.dirname(File.dirname(File.dirname(__FILE__)))
require 'ext/horizons/body_data_sheet_parser'
require 'date'

module Tengai
  class Body
    attr_accessor :revised_on, :name, :id

    def initialize(attributes = {})
      self.revised_on = attributes.fetch(:revised_on) { nil }
      self.name = attributes.fetch(:name) { nil }
      self.id = attributes.fetch(:id) { nil }
    end

    def self.find(client, body, parser=BodyDataSheetParser)
      data = client.cmd('String' => body.to_s, 'Match' => /<cr>:\s*$/)
      parser.parse(data, new)
    end

    def ==(other)
      id == other.id
    end
  end
end
