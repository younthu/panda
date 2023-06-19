# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
require 'support/request_helpers'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../test/dummy/config/environment'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
Dir[Pathname(File.dirname(__FILE__)).join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.

# Resolving pending migrations issue in rspec. https://github.com/rspec/rspec-rails/issues/1330,
# another point, https://stackoverflow.com/questions/14465754/how-to-manage-migrations-for-a-rails-engine-dummy-app
# So, keep as it.
# The previous duplicated migrations issue caused by duplicated migrations_path appending in different file.
# Resolved by removing duplicated migration files appending. please check current commit for the whole change.
ActiveRecord::Migrator.migrations_paths = [File.expand_path("../test/dummy/db/migrate", __dir__)] # 欺骗一下rspec, 跑rspec之前先跑bin/rails db:drop db:create db:migrate  RAILS_ENV=test
# ActiveRecord::Migrator.migrations_paths << File.expand_path('../db/migrate', __dir__)
begin

  puts ">>>==========================================="
  puts "begin check test schema..."
  puts "ActiveRecord::Migrator.migrations_paths:"
  puts ActiveRecord::Migrator.migrations_paths
  puts "<<<==========================================="
  ActiveRecord::Migration.maintain_test_schema! # ~/.rvm/gems/ruby-3.1.1/gems/activerecord-7.0.4/lib/active_record/migration.rb:627
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.swagger_dry_run = false

  FactoryBot.reload
  config.include FactoryBot::Syntax::Methods

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end
