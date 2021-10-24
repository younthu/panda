require_relative "lib/panda/version"

Gem::Specification.new do |spec|
  spec.name        = "panda"
  spec.version     = Panda::VERSION
  spec.authors     = ["Zhiyong Yang"]
  spec.email       = ["evil_eve_live@outlook.com"]
  spec.homepage    = "https://github.com/younthu/panda"
  spec.summary     = "一个巨型app，集合各种常用的功能. 一个模版app。一个引擎。警告: 本Engine不提供任何兼容性支持，版本之间随时不兼容，请谨慎。"
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

<<-Comment
  # 微信支付
  gem 'wx_pay'

  # 微信登录
  gem 'wechat'
  gem "devise-jwt"
  gem 'warden-jwt_auth', '= 0.4.0'
Comment

  spec.add_dependency "wx_pay"
  spec.add_dependency "wechat"
  # spec.add_dependency "devise-jwt"
  # spec.add_dependency "warden-jwt_auth"


  # devise 用户管理, gem 'devise'
  spec.add_dependency 'devise'

  # devise token support, https://github.com/lynndylanhurley/devise_token_auth
  spec.add_dependency 'devise_token_auth'


  # swag, 包含了rspec-rails, rswag-specs, ref: https://github.com/rswag/rswag
  spec.add_dependency 'rswag'

  # active_admin
  spec.add_dependency 'activeadmin'

  # Localization
  spec.add_dependency 'rails-i18n'
  spec.add_dependency 'devise-i18n'
  spec.add_dependency 'kaminari-i18n'

  # 图片上传
  spec.add_dependency 'carrierwave'

  # 权限管理
  spec.add_dependency 'cancancan'

  # 角色管理
  spec.add_dependency 'rolify'

  spec.add_dependency 'sass-rails'
  # development dependencies
  # spec.add_development_dependency "pry"         # powerful ruby console, for debugging.
  # spec.add_development_dependency 'pry-rails'   # pry rails support
  spec.add_dependency 'rspec-rails' # integration test, add_development_dependency not work.
  spec.add_dependency 'rspec'

end
