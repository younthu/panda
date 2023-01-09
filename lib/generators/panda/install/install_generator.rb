class Panda::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('templates', __dir__)

  # 添加panda 路由
  def mount_panda_in_routes
    insert_into_file 'config/routes.rb', "\n  mount Panda::Engine => '/panda'\n", after: "Rails.application.routes.draw do\n"
  end

  # 拷贝migration files
  def install_migration_files

  end

  # 安装 user的内容到user.rb和user migration
  def install_user_model
    # TODO: 把user的扩展安装到user.rb里面去
    copy_file "user.rb", "app/models/"
    puts "用户模型已经生成，请通过rails g panda:install:migrations来安装"
  end

  def install_docker_files
    # TODO, 用模板方法去做定制化.
    copy_file "Docker-compose.yml", "Docker-compose.yml"
    copy_file "Dockerfile", "Dockerfile"
    copy_file "entrypoint.sh", "entrypoint.sh"
  end
end
