module Fixtures
  def self.io
    File.read('spec/fixtures/bodies/501.txt')
  end

  def self.mars
    File.read('spec/fixtures/bodies/499.txt')
  end

  def self.earth
    File.read('spec/fixtures/bodies/399.txt')
  end

  def self.ephemeris
    File.read('spec/fixtures/ephemerides/mars_observed_by_earth_from_2012_12_28_to_29.txt')
  end

  def self.vector_ephemeris
    File.read('spec/fixtures/ephemerides/mars_vectors_from_solar_system_center.txt')
  end
end
