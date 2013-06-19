require 'csv'

module Tengai
  class EphemerisTableParser
    def self.parse(table)
      empty_nils = ->(value) { value || '' }
      strip      = ->(value) { value.strip }

      table = CSV.parse(
        table,
        headers:            true,
        header_converters:  [empty_nils, strip, :symbol],
        converters:         [empty_nils, strip])

      table.map do |row|
        row.to_hash.tap {|r| r.delete(:'') }
      end
    end
  end
end
