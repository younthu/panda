1. rspec, pending migrations: https://github.com/rspec/rspec-rails/issues/1330
   1. For now I just have this in the spec_helper, which solves my problem: ActiveRecord::Migrator.migrations_paths = 'spec/dummy/db/migrate'
2. 