require 'date'
require 'virtus'

class VectorEphemerisTable
  include Enumerable

  def initialize(rows)
    @rows = rows
  end

  def self.new_with_table(rows)
    rows.map {|row| Row.new(row) }
    new(rows)
  end

  def each(&block)
    @rows.each(&block)
  end

  class Row
    include Virtus
    attribute :jdct, Date
    attribute :x, Float
    attribute :y, Float
    attribute :z, Float
    attribute :vx, Float
    attribute :vy, Float
    attribute :vz, Float
    attribute :lt, Float
    attribute :rg, Float
    attribute :rr, Float

    def jdct=(julian)
      super Date.jd(julian.to_f)
    end
  end
end