require_relative "lib/panda/version"

Gem::Specification.new do |spec|
  spec.name        = "panda"
  spec.version     = Panda::VERSION
  spec.authors     = ["Zhiyong Yang"]
  spec.email       = ["evil_eve_live@outlook.com"]
  spec.homepage    = "https://github.com/younthu/panda"
  spec.summary     = "一个巨型app，集合各种常用的功能. 一个模版app。一个引擎。"
  spec.description = "它包含了常用的功能。用户模型，登录登出，后台管理，rest api token管理. 微信相关的功能，微信支付相关的功能。小程序相关的功能。苹果推送。"
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/younthu/panda.git"
  spec.metadata["changelog_uri"] = "https://github.com/younthu/panda/blob/master/CHANGELOG.md"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.1.3", ">= 6.1.3.2"
end
