$:.unshift File.dirname(File.dirname(File.dirname(__FILE__)))
require 'ext/horizons/body_data_sheet_parser'
require 'virtus'

module Tengai
  class Body
    include Virtus
    attribute :revised_on, Date
    attribute :name, String
    attribute :id, Integer

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
