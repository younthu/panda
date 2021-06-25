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

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Roadmap
1. [ ] User
	1. [ ] User model
	1. [ ] Rest api for Avatar upload
	1. [ ]
	1. [ ] Identity model
	1. [ ] Profile model
1. [ ] Login with devise
1. [ ] Login with wechat
1. [ ] User
1. [ ] wx_pay, WechatMiniService from Tekapic.
1. [ ] 优惠券
1. [ ] 常用可通用的功能写到subfolder里面以gem的形式加载.
1. [ ] swagger

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

