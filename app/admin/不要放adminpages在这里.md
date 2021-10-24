请把admin pages放到lib/panda/admin 目录下面去.

下面内容引用自`lib/panda/engine.rb`:

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
