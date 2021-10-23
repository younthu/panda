require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
require "panda"

module Dummy
  class Application < Rails::Application
    config.load_defaults Rails::VERSION::STRING.to_f

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")


    # DateTime.now, Time.now是UTC时间, Time.current是TimeZone时间, 没有DateTime.now.
    # 1.minutes.ago是TimeZone时间。
    # Date.today 是utc时间, Date.current是Timezone时间
    config.i18n.available_locales = [:en,:'zh-CN']
    config.i18n.default_locale = :'zh-CN'
    config.time_zone = "Beijing" # include ActiveSupport::TimeZone.all
  end
end
