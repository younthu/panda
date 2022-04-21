# requires all dependencies, https://guides.rubyonrails.org/v5.1/autoloading_and_reloading_constants.html
Gem.loaded_specs['panda'].dependencies.each do |d|
  # puts "Loading #{d.name}"
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
require 'custom_message_error'
require 'utils/random.rb'

module Panda
  # this function maps the vars from your app into your engine
  self.mattr_accessor :token_method # 是用secure_token 还是 devise token
  self.token_method = :devise_token
  # self.token_method = :secure_token
  # add default values of more config vars here

  def self.setup(&block)
    yield self
  end
end
