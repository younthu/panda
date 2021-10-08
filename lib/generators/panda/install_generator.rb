# frozen_string_literal: true

require 'rails/generators/active_record'

module Panda
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include ::Rails::Generators::Migration

      desc 'Install Panda support files'
      source_root File.expand_path('templates', __dir__)

      def copy_migrations
        migration_template(
          'migrations/create_panda_identities.rb.erb',
          'db/migrate/create_panda_identities.rb',
          migration_version: migration_version
        )

        migration_template(
          'migrations/create_panda_profiles.rb.erb',
          'db/migrate/create_panda_profiles.rb',
          migration_version: migration_version
        )

        migration_template(
          'migrations/devise_token_auth_create_panda_users.rb.erb',
          'db/migrate/devise_token_auth_create_panda_users.rb',
          migration_version: migration_version
        )

        migration_template(
          'migrations/devise_create_panda_admin_users.rb.erb',
          'db/migrate/devise_create_panda_admin_users.rb',
          migration_version: migration_version
        )

        migration_template(
          'migrations/create_active_admin_comments.rb.erb',
          'db/migrate/create_active_admin_comments.rb',
          migration_version: migration_version
        )

        migration_template(
          'migrations/add_mobile_to_users.rb.erb',
          'db/migrate/add_mobile_to_users.rb',
          migration_version: migration_version
        )

        migration_template(
          'migrations/add_avatar_to_users.rb.erb',
          'db/migrate/add_avatar_to_users.rb',
          migration_version: migration_version
        )
      end

      class << self
        def next_migration_number(dirname)
          ::ActiveRecord::Generators::Base.next_migration_number(dirname)
        end
      end

      private

      def migration_version
        "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
      end
    end
  end
end
