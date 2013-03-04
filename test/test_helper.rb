$:.unshift File.dirname(__FILE__)
require 'simplecov'
SimpleCov.start do
  add_filter '/test/'
end
require 'test/unit'
require 'mocha/setup'
require 'forgery'
require 'pry'

require 'tengai'

include Tengai

module Fixtures
  def self.mars
    File.read('test/fixtures/bodies/499.txt')
  end

  def self.earth
    File.read('test/fixtures/bodies/399.txt')
  end

  def self.ephemeris
    File.read('test/fixtures/ephemerides/mars_observed_by_earth_from_2012_12_28_to_29.txt')
  end

  def self.vector_ephemeris
    File.read('test/fixtures/ephemerides/mars_vectors_from_solar_system_center.txt')
  end
end
