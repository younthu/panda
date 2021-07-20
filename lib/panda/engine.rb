module Panda
  class Engine < ::Rails::Engine
    isolate_namespace Panda
    config.autoload_paths += %W(#{config.root}/lib/modules) # FIXME: load correct path
  end
end
