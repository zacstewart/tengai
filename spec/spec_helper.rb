$:.unshift File.dirname(__FILE__)
require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
end
require 'forgery'
require 'pry'

require 'tengai'

include Tengai
