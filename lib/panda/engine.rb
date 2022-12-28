module Panda
  class Engine < ::Rails::Engine
    isolate_namespace Panda

    # Define a resource inside an engine, https://github.com/activeadmin/activeadmin/wiki/Define-a-resource-inside-an-engine
    # Note that it is very important to keep the admin/*.rb definitions out of the Rails' eager load paths to avoid loading
    # these files more than once. If they get loaded multiple times, you are likely to experience weird problems with
    # duplicated filters in the filter forms, duplicate action_item buttons, broken belongs_to definitions, etc.
    # And that will happen only in production (ie. when config.cache_classes = true).
    #
    # For example, your engine's lib/ folder is a good choice in contrast to its app/ folder (if any).
    # That's because app/ is in the eager load paths and all *.rb files there get recursively loaded by Rails when
    # config.cache_classes = true (usually the case in production environments). However, ActiveAdmin takes care to
    # load these files too and that will be the reason for them to get loaded more than once.
    initializer :panda do
      ActiveAdmin.application.load_paths+= Dir[File.dirname(__FILE__) + '/admin']
    end

    # 不要append migration files。 通过rake task把migration files安装到目标app里面去更灵活，spree就是这样做的。
    # initializer :append_migrations do |app|
    #   unless app.root.to_s.match root.to_s
    #     config.paths["db/migrate"].expanded.each do |expanded_path|
    #       app.config.paths["db/migrate"] << expanded_path
    #     end
    #   end
    # end

    # 加载本地化文件
    config.before_initialize do
      config.i18n.load_path += Dir["#{config.root}/config/locales/**/*.yml"]
    end

    # eager load, auto load, https://blog.arkency.com/2014/11/dont-forget-about-eager-load-when-extending-autoload/
    config.eager_load_paths += Dir["#{config.root}/app/services/*"]
  end
end
