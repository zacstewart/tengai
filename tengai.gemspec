$LOAD_PATH.unshift 'lib'
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

  s.add_development_dependency 'rake'
  s.add_development_dependency 'mocha'

  s.files = %w(
    Gemfile
    Gemfile.lock
    Rakefile
    lib/tengai.rb
    lib/tengai/body.rb
    lib/tengai/client.rb
    lib/tengai/version.rb
    tengai.gemspec
    test/fixtures/bodies/10.txt
    test/fixtures/bodies/399.txt
    test/fixtures/bodies/499.txt
    test/fixtures/bodies/501.txt
    test/fixtures/major_bodies.txt
    test/test_helper.rb
    test/units/body_test.rb
  )
end
