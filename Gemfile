source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.1'
# Specify your gem's dependencies in panda.gemspec.
gemspec

gem 'rails', "~> 7.0.4"
gem 'rswag'
gem 'jbuilder'
group :development do
  gem 'sqlite3'

  # pry rails for dev console
  gem 'pry'
  gem 'pry-rails'
  gem 'annotate'
end

# To use a debugger
# gem 'byebug', group: [:development, :test]

# ruby 3以后必须指定web server
gem "puma", "~> 5.3"

gem 'sass-rails'

gem "devise-i18n", "~> 1.10"

gem "devise", "~> 4.8"

gem "activeadmin", "~> 2.9"

gem 'aliyun-cloud_sms'
gem 'rails_param'

gem 'rswag'

group :development, :test do
  gem 'bullet'
  gem 'byebug'

  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'standard', require: false

  gem 'rspec-rails'

  gem 'airborne'

  gem 'factory_bot_rails'
  gem 'faker'
  gem 'nokogiri'

  gem 'rack-mini-profiler'
  # gem 'meta_request'
end