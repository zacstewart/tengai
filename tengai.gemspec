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

  s.files = %w(
    Gemfile
    Gemfile.lock
    lib/tengai.rb
    lib/tengai/body.rb
    lib/tengai/client.rb
    lib/tengai/version.rb
    tengai.gemspec
  )
end
