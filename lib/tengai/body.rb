require 'stringio'
require 'date'

module Tengai
  class Body
    attr_reader :data, :revised_on, :name, :id

    HEADER_PATTERN = %r{\s*Revised\s*:\s*([A-Z][a-z]{2} \d{2}, \d{4})\s+(.*)\s{3,}(\d+)}.freeze

    def self.find(client, body)
      data = client.cmd('String' => body.to_s, 'Match' => /<cr>:\s*$/)
      self.new(data)
    end

    def initialize(data)
      parse_data_page(data)
    end

    def ==(other)
      id == other.id
    end

    private
    def parse_data_page(data)
      data = StringIO.new(data.split(/\*+$/)[1][1..-1])

      header = data.gets.chomp
      parse_header(header)

      data.gets # Chomp empty line
      @data = data.readlines.join.chomp
    end

    def parse_header(header)
      parts = header.match(HEADER_PATTERN)
      @revised_on = Date.parse(parts[1].strip)
      @name = parts[2].strip
      @id = parts[3].strip.to_i
    end
  end
end
