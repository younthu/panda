# frozen_string_literal: true

# Rails generator tutorial: https://guides.rubyonrails.org/generators.html
# Thor tutorial: https://www.rubydoc.info/gems/thor/Thor/Actions
#
# Generators can inherit from Rails::Generators::Base. When a generator is invoked, each public method in the generator is executed sequentially in the order that it is defined. ref: https://guides.rubyonrails.org/generators.html#creating-your-first-generator
class Panda::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('templates', __dir__)
  # 模板public方法执行的顺序是按定义的顺序来的。

  # 安装依赖的gems
  def install_gems
    gem "annotate", group: :development
  end

  def install_config
    if yes?("生成settings.yml文件?[Yn]")
      generate "config:install"
      copy_file "settings.yml.sample", "settings.local.yml"
    end

    copy_file 'zh-CN.yml', 'zh-CN.yml'
  end
  # 添加panda 路由
  def mount_panda_in_routes
    if yes?("添加 mount Panda::Engine到routes.rb?")
      insert_into_file 'config/routes.rb', "\n  mount Panda::Engine => '/'\n", after: "Rails.application.routes.draw do\n"
    end
  end

  # 拷贝migration files
  def install_migration_files
    rake "panda:install:migrations"
  end


  # 安装 user的内容到user.rb和user migration
  def install_user_model
    if yes?("生成user.rb?")
      copy_file "user.rb", "app/models/user.rb"
      puts "用户模型已经生成，请通过rails g panda:install:migrations来安装migration files"
    end
  end

  def install_deploy_scripts
    if yes?("生成install scripts?[Yn]")
      puts "生成ssh_deploy.sh"
      folder_name = File.basename(Dir.getwd)
      app_name = ask("container的英文名叫什么? [#{folder_name}]")
      app_name = folder_name if app_name.blank?
      template "ssh_deploy.sh", "ssh_deploy.sh", {app_name: }
      template "restart.sh", "restart.sh", {app_name: }
    end
  end

  def install_docker_files
    if yes?("生成Docker files?[Yn]")
      folder_name = File.basename(Dir.getwd)
      app_name = ask("App的英文名叫什么? [#{folder_name}]")
      app_name = folder_name if app_name.blank?

      db_password=SecureRandom.base58(18)
      puts "app_name = #{app_name}"
      # TODO, 用模板方法去做定制化.
      template "Docker-compose.yml.erb", "Docker-compose.yml", {app_name: app_name, db_password:}
      copy_file "Dockerfile", "Dockerfile"
      template "entrypoint.sh", "entrypoint.sh", {app_name: app_name, db_password:}

      #  生成env 文件， 默认.env为development, .env.stage为stage, .env.production为production. 如果需要使用production env，  把.env.production改名为.env, 覆盖.env即可.
      template "sample.env", ".env", {app_name:, db_password:,  env: "development"}
      template "sample.env", ".env.development", {app_name:, db_password:,  env: "development"}
      template "sample.env", ".env.stage", {app_name:, db_password:,  env: "stage"}
      template "sample.env", ".env.production", {app_name:, db_password:,  env: "production"}
    end
  end

  def config_activeadmin_addons
    generate 'activeadmin_addons:install' # 安装activeadmin_addons
  end
end
