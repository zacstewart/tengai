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
