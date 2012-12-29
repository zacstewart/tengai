$:.unshift File.dirname(__FILE__)
require 'test/unit'
require 'mocha/setup'

require 'tengai'

include Tengai

module Fixtures
  def self.mars
    File.read('test/fixtures/bodies/499.txt')
  end

  def self.ephemeris
    File.read('test/fixtures/ephemerides/mars_observed_by_earth_from_2012_12_28_to_29.txt')
  end
end
