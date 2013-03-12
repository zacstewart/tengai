require 'csv'

module Tengai
  class EphemerisTableParser
    def self.parse(table)
      strip = lambda {|f| (f || '').strip }

      table = CSV.parse(
        table,
        headers: true,
        header_converters: [strip, :symbol],
        converters: [strip])

      table.map do |row|
        row.to_hash.tap{|r| r.delete(:'') }
      end
    end
  end
end
