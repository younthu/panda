# requires all dependencies
Gem.loaded_specs['panda'].dependencies.each do |d|
  require d.name
 end

require 'devise'

require "panda/version"
require "panda/engine"

module Panda
  # Your code goes here...
end
