# requires all dependencies, https://guides.rubyonrails.org/v5.1/autoloading_and_reloading_constants.html
Gem.loaded_specs['panda'].dependencies.each do |d|
  puts "Loading #{d.name}"
  if d.name == 'aliyun-cloud_sms' # aliyun-cloud_sms require path里面没有aliyun-cloud_sms.rb 详见doc/issues/aliyun_cloud_sm_cannot-load.md
    require 'aliyun/cloud_sms'
  else
    require d.name
  end
end

# require ''

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
