$:.unshift File.dirname(File.dirname(File.dirname(__FILE__)))
require 'ext/horizons/body_data_sheet_parser'
require 'date'

module Tengai
  class Body
    attr_accessor :revised_on, :name, :id

    def initialize(attributes)
      self.revised_on = attributes.fetch(:revised_on)
      self.name = attributes.fetch(:name)
      self.id = attributes.fetch(:id)
    end

    def revised_on=(date)
      date = Date.parse(date) if date.respond_to?(:to_str)
      @revised_on = date
    end

    def id=(id)
      @id = Integer(id)
    end

    def self.find(client, body, parser=BodyDataSheetParser)
      data = client.cmd('String' => body.to_s, 'Match' => /<cr>:\s*$/)
      data = parser.parse(data)
      self.new(data)
    end

    def ==(other)
      id == other.id
    end
  end
end
