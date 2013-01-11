$LOAD_PATH.unshift 'lib'
$LOAD_PATH.unshift 'ext'
require 'tengai/version'

Gem::Specification.new do |s|
  s.name        = 'tengai'
  s.version     = Tengai::VERSION.dup
  s.summary     = 'Ruby wrapper for the NASA HORIZONS telnet system'
  s.description = 'Ruby wrapper for the NASA HORIZONS telnet system'
  s.homepage    = 'http://github.com/zacstewart/tengai'
  s.authors     = ['Zac Stewart']
  s.email       = ['zgstewart@gmail.com']

  s.require_paths = ['lib']

  s.add_development_dependency 'pry'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'mocha'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'forgery'

  s.files = %w(
    .gitignore
    .travis.yml
    Gemfile
    README.md
    Rakefile
    lib/tengai.rb
    lib/tengai/body.rb
    lib/tengai/client.rb
    lib/tengai/ephemeris.rb
    lib/tengai/requests/ephemeris_request.rb
    lib/tengai/version.rb
    tengai.gemspec
    test/fixtures/bodies/10.txt
    test/fixtures/bodies/399.txt
    test/fixtures/bodies/499.txt
    test/fixtures/bodies/501.txt
    test/fixtures/ephemerides/mars_observed_by_earth_from_2012_12_28_to_29.txt
    test/fixtures/major_bodies.txt
    test/integration/body_integration_test.rb
    test/test_helper.rb
    test/unit/body_test.rb
    test/unit/ephemeris_test.rb
  )
end
