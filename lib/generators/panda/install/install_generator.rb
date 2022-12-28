class Panda::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('templates', __dir__)

  # 添加panda 路由
  def mount_panda_in_routes
    insert_into_file 'config/routes.rb', "\n  mount Panda::Engine => '/panda'\n", after: "Rails.application.routes.draw do\n"
  end

  # 拷贝migration files
  def install_migration_files
    # TODO:
  end

  # 安装 user的内容到user.rb
  def install_user_model
    # TODO: 把user的扩展安装到user.rb里面去
  end
end
