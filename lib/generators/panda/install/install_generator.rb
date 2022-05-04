class Panda::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('templates', __dir__)

  def mount_panda_in_routes
    insert_into_file 'config/routes.rb', "\n  mount Panda::Engine => '/panda'\n", after: "Rails.application.routes.draw do\n"
  end
end
