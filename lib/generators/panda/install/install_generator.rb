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
    generate "config:install"
    #TODO: copy sample settings file and sample local settings file to target app
  end
  # 添加panda 路由
  def mount_panda_in_routes
    if yes?("添加 mount Panda::Engine到routes.rb?")
      insert_into_file 'config/routes.rb', "\n  mount Panda::Engine => '/'\n", after: "Rails.application.routes.draw do\n"
    end
  end

  # 拷贝migration files
  def install_migration_files

  end


  # 安装 user的内容到user.rb和user migration
  def install_user_model
    # TODO: 把user的扩展安装到user.rb里面去
    copy_file "user.rb", "app/models/"
    puts "用户模型已经生成，请通过rails g panda:install:migrations来安装migration files"
  end

  def install_deploy_scripts
    copy_file "ssh_deploy.sh", "ssh_deploy.sh"
  end

  def install_docker_files
    folder_name = File.basename(Dir.getwd)
    app_name = ask("App的英文名叫什么? [#{folder_name}]")
    app_name = folder_name if app_name.blank?

    db_password=SecureRandom.base58(18)
    puts "app_name = #{app_name}"
    # TODO, 用模板方法去做定制化.
    template "Docker-compose.yml.erb", "Docker-compose.yml", {app_name: app_name, db_password:}
    copy_file "Dockerfile", "Dockerfile"
    copy_file "entrypoint.sh", "entrypoint.sh"
  end
end
