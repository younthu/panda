# Panda
Short description and motivation.


## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'panda'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install panda
```


## Test
1. run rails test: `rails test`
   1. 注意fixture加载的方式: `panda_users(:one)`, 需要加namespace `panda_`
1. run dummy app in the root folder: 'rails s'.
   1. 魔法在`panda/bin/rails`里面. `APP_PATH = File.expand_path('../test/dummy/config/application', __dir__)`
1. postman scripts.
1. 后台登录: http://localhost:3000/admin

## Development
1. 更新版本号: `lib/panda/version`
## Rails tasks

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Roadmap
1. [ ] User
	1. [x] User model
	1. [x] Rest api for Avatar upload
	1. [x] Identity model
	1. [x] Profile model
1. [ ] Login with devise
    1. [x] 手机登录
	1. 微信登录
	1. 邮箱登录
	1. 账号密码登录
	1. 苹果登录
1. [ ] Login with wechat
1. [ ] User
1. [ ] wx_pay, WechatMiniService from Tekapic.
1. [ ] 优惠券
1. [ ] 常用可通用的功能写到subfolder里面以gem的形式加载.
1. [ ] swagger
1. [ ] Kaminari pagination
1. [ ] Localization
1. [ ] ElasticSearch
1. [ ] Redis
1. [ ] ELK Log
1. [ ] Sidekiq
1. [ ] Puma auto restart. 解决ruby内存泄漏到问题
1. [ ] OAuth
1. [ ] JWT
1. [ ] RPush
1. [ ] ActiveAdmin
1. [ ] 朋友圈
   	1. [ ] 照片
   	1. [ ] 文字
	1. [ ] 点赞
	1. [ ] 评论
	1. [ ] 搜索
	1. [ ] 订阅
1. [ ] Panda installer
	1. [ ] 添加自动加载路径`routes/*.rb`到`config/application.rb`里面去
	1. [ ]
1. [ ] 订单系统
1. [ ] 支付系统
1. [ ] spree商城
1. [ ] sentry rails
1. [ ] newrelic 免费版
1. [ ] devise authentication in go
1. [ ] APIs in go
1. [ ] nginx configuration
1. [ ] APIs in python
1. [ ] devise authentication in python
1. [ ] 小程序generator
1. [ ] RN app generator
1. [ ]


## Notes
1. Rails Engine和Rails Plugin的区别.
1. 加载本地gem: `gem 'core', path: '../core'`
# Famous engine
1. Rails is the biggest engine.
1. [Thredded](https://github.com/thredded/thredded), Thredded is a Rails 4.2+ forum/messageboard engine. Its goal is to be as simple and feature rich as possible.
1. [Spree](https://github.com/spree/spree),Spree is a complete open source e-commerce solution built with Ruby on Rails.
1. [Devise](https://github.com/heartcombo/devise),Flexible authentication solution for Rails with Warden.
1.

# Useful gems
1.
# Useful links
1. [Start with rails engine](https://guides.rubyonrails.org/engines.html)
1. [A Guide to Rails Engines in the Wild: Real World Examples of Rails Engines in Action](https://www.toptal.com/ruby-on-rails/rails-engines-in-the-wild-real-world-examples-of-rails-engines-in-action)
1. [Rails 引擎初探](https://www.jianshu.com/p/c60aafdb2a85)

# notes
1. 默认Engine不会加载gemspec里面的内容,导致`uninitialized constant DeviseTokenAuth`错误.
   解决办法:
   ~~~ruby
   # 把下面的内容加入到lib/panda.rb顶部, https://stackoverflow.com/questions/5159607/rails-engine-gems-dependencies-how-to-load-them-into-the-application
   # requires all dependencies
	Gem.loaded_specs['yourengine'].dependencies.each do |d|
	require d.name
	end
   ~~~
1.

## mount activeadmin inside engine
1. [Define a resource inside an engine](https://github.com/activeadmin/activeadmin/wiki/Define-a-resource-inside-an-engine)
1. [Example Engines](https://github.com/activeadmin/activeadmin/wiki#engines-gems)
