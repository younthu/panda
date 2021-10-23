# requires all dependencies
Gem.loaded_specs['panda'].dependencies.each do |d|
  require d.name
 end

require 'devise'

require "panda/version"
require "panda/engine"

module Panda
  # this function maps the vars from your app into your engine
  self.mattr_accessor :available_login_validations, :default_login_validation
  self.available_login_validations = [:password, :secure_token]
  self.default_login_validation = :password
  # add default values of more config vars here

  def self.setup(&block)
    yield self
  end
end
