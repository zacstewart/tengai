require 'date'

module Tengai
  class VectorEphemerisTable
    include Enumerable

    def initialize(rows)
      @rows = rows
    end

    def self.new_with_table(rows)
      new(rows.map(&Row.method(:new)))
    end

    def each(&block)
      @rows.each(&block)
    end

    class Row
      attr_accessor :jdct, :x, :y, :z, :vx, :vy, :vz, :lt, :rg, :rr

      def initialize(attributes)
        self.jdct = attributes.fetch(:jdct)
        self.x = attributes.fetch(:x)
        self.y = attributes.fetch(:y)
        self.z = attributes.fetch(:z)
        self.vx = attributes.fetch(:vx)
        self.vy = attributes.fetch(:vy)
        self.vz = attributes.fetch(:vz)
        self.lt = attributes.fetch(:lt)
        self.rg = attributes.fetch(:rg)
        self.rr = attributes.fetch(:rr)
      end

      def jdct=(julian)
        @jdct = DateTime.jd(julian.to_f)
      end

      def x=(x); @x = Float(x); end
      def y=(y); @y = Float(y); end
      def z=(z); @z = Float(z); end
      def vx=(vx); @vx = Float(vx); end
      def vy=(vy); @vy = Float(vy); end
      def vz=(vz); @vz = Float(vz); end
      def lt=(lt); @lt = Float(lt); end
      def rg=(rg); @rg = Float(rg); end
      def rr=(rr); @rr = Float(rr); end

    end
  end
end
