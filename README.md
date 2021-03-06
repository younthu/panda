# Panda
Panda是一个业务代码聚合引擎，Rails Engine. 所有功能开箱即用。常用的用户系统，缓存和任务系统, 消息推送, 短信验证码, 管理后台, etc.


# Quick start

1. Add gems
    1. Add `gem 'panda', git: 'https://github.com/younthu/panda.git'` to Gemfile
    1. Add `gem 'annotate'` to development group.
    1. Add `  mount Panda::Engine => "/panda"` to `routes.rb`
2. `bundle install`
3. `rails g config:install`
   1. copy `test/dummy/config/settings.yml` to `config/settings.yml`
4. `rails g panda:install & rails g panda:initializer`
5. `rails db:create && rails db:migrate`
6. start server: `rails s`
7. start sidekiq(optional): `sidekiq`
8. start rpush(optional): `rpush start`
9. check app info: `rails app:about`


# Setup

Api, rest api controller可以继承Panda::Api::Controller, 这个api包含了rest api登录的基本功能.

安装迁移文件:
~~~sh
rails panda:install:migrations
~~~

# 目录结构
1. 遵循传统的Rails项目结构。
2. 这是一个Rails Engine, 多了一个Dummy App，所以代码目录结构在细节上和传统Rails项目有区别。
3.
# Settings
见[./config/readme.md](./config/readme.md)

# Features

## Rpush

1. start rpush(optional): `rpush start`
    1. Both two commands below work in mac, but, not in linux.
    1. send notification to a device: `rails rpush:p8push_to_device["你好","BF1F297A3B62D1517BB19D5D67BD0BC72D438F94F016DAD6E2B175AE01BFC38D"]`
    1. send notification to device: `rails rpush:push_to_device["你好","BF1F297A3B62D1517BB19D5D67BD0BC72D438F94F016DAD6E2B175AE01BFC38D"]`
2. 升级rpush:
   1. 升级gem包: `bundle update rpush`
   2. 重新生成migration files: `rpush init`

## 微信支付

## 权限管理
1. Panda::AdminRole是给后台用户角色定义用的。目前没有对一般用户权限做支持，可以在后期根据需求来添加。
## Swagger

## Test
1. run rails test: `rails test`
   1. 注意fixture加载的方式: `panda_users(:one)`, 需要加namespace `panda_`
1. run dummy app in the root folder: 'rails s'.
   1. 魔法在`panda/bin/rails`里面. `APP_PATH = File.expand_path('../test/dummy/config/application', __dir__)`
1. postman scripts.
1. 后台登录: `http://localhost:3000/admin`

## Development
1. 更新版本号: `lib/panda/version`
1. 调试panda的时候可以引用本地panda, 这样可以直接改panda的代码调试: ``gem 'panda', path: '../panda'``
1. 更新Swagger Api Doc: `rspec --format Rswag::Specs::SwaggerFormatter --order defined`


## Rails tasks

## Overriding Models and Controller

[Overriding Models and Controller](https://edgeguides.rubyonrails.org/engines.html#overriding-models-and-controllers)

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Roadmap
1. [x] User
    1. [x] User model
    1. [x] Rest api for Avatar upload
    1. [x] Identity model
    1. [x] Profile model
    2. [ ] 账户注销
    6. [ ] 会员等级 
    7. [ ] captcha
    8. [ ] 新用户邀请
2. [ ] Login with devise
    1. [x] 手机登录
    1. [x] 微信登录
    2. [ ] 通过关注微信公众号来绑定账号
    3. [x] 邮箱登录
    4. [x] 账号密码登录
    5. [ ] 扫码登陆
    6. [ ] 苹果登录
7. [ ] Feature Toggle
3. [x] 聊天
4. [ ] 站内信
3. [x] 基于Secure_token的token管理和身份认证.
   1. 目前`secure_token`和`devise`不能同时在`controller`里面用，因为有命名冲突,`current_user`和`authenticate_user!`都冲突了。目前的解决办法是通过`Panda.token_method == :secure_token`来决定是用secure_token还是`devise`
   1. 目前登录时两种token都会返回. `devise token`在`auth_token`下面, `secure_token`在`secure_token`字段
   1. 切换token认证方式需要去panda.rb里面设置token_method, 用postman测试过myinfo api, secure_token是工作的.
   1.
4. [x] Login with wechat
5. [x] User
7. [x] 后台用户权限管理
   1. [x] Roles
   1. [x] Permissions
   1. [ ] 角色配置页面, 分管理员和用户
   1. [ ] 权限配置页面, 分管理员和用
8. [x] wx_pay, WechatMiniService from Tekapic.
9. [x] config gem with settings files.
10. [ ] 优惠券
11. [ ] 常用可通用的功能写到subfolder里面以gem的形式加载.
12. [ ] swagger
13. [ ] Kaminari pagination
14. [x] Localization
15. [ ] ElasticSearch
16. [ ] Redis
17. [ ] ELK Log
18. [ ] Sidekiq
19. [ ] Puma auto restart. 解决ruby内存泄漏到问题
20. [x] CORS
     1. 默认关闭CORS
        [//]: # (   2. `rails g panda:install` 会生成`config/cors/initilaizer.rb`)
20. [ ] OAuth
21. [ ] JWT
22. [ ] RPush
23. [ ] Log rotation
24. [ ] ActiveAdmin
    1. [x] 后台
25. [ ] 朋友圈
        1. [ ] 照片
        1. [ ] 文字
     1. [ ] 点赞
     1. [ ] 评论
     1. [ ] 搜索
     1. [ ] 订阅
26. [ ] Panda installer
     1. [ ] 添加自动加载路径`routes/*.rb`到`config/application.rb`里面去
     1. [ ]
27. [ ] 基于数据库的配置
     1. [ ] config做基于文件的静态配置
     1. [ ] rails-settings-cached做基于数据库的动态配置管理，给运维人员用.
28. [ ] 订单系统
29. [ ] 支付系统
    1.  [ ] 微信支付
    2.  [ ] 支付宝支付
    3.  [ ] 苹果支付
30. [ ] spree商城
31. [ ] sentry rails
32. [ ] newrelic 免费版
33. [ ] devise authentication in go
34. [ ] MQTT
35. [ ] Websocket
36. [ ] Message Queue, kafka, 削峰填谷
37. [ ] APIs in go
38. [ ] nginx configuration
39. [ ] APIs in python
40. [ ] devise authentication in python
41. [ ] 工作流引擎
42. [ ] [Rails Settings Cached]( https://github.com/huacnlee/rails-settings-cached )
43. [ ] 禁用panda的dashboard, settings里面禁用
44. [ ] App版本控制
45. [ ] 类似Redmine的插件系统
46. [ ] 积分系统
47. [ ] 虚拟货币系统
48. [ ] 抽奖系统
49. [ ] 调试
    1. [ ] 系统探针？
    2. [ ] 远程日志?
    3. [ ] 数据库数据记录自诊断
50. [ ] 测试
    1. [ ] UT
    2. [ ] Postman
    3. [ ] Jmeter
51. Docker
    1. [ ] Docker文件
    2. [ ] Docker-compose文件
    3. [ ] Docker-compose for dummy
    4. [ ] K8S Helm Chart
52. 运维
    1. [ ] 拷贝ansible scripts from yoga
    2. [ ] 拷贝ansible scripts with panda:install
53. [ ] 技术文档,gitbook.
54. [ ] 用户基本的API request频率限制, 防止攻击.

# Rails generators

1. [ ] Docker-compose template generator
2. [ ] Panda settings generator(config rb and settings yaml)
    3. [ ] ansible scripts
    4. [ ]  
3. [ ] Seeds generator
4. [ ] Generator网页，点击直接生成目标内容的界面。
5. [x] API/rspec Generator from Gu
   1. 说明见`lib/generators/panda/readme.md`
6. [ ] 小程序generator
7. [ ] React Native app generator


# 性能问题
常用来讲，性能问题不可避免。性能问题需要通过微服务架构来解决，规划如下:

1. rails做快速业务开发和数据库建模，常用的业务逻辑和代码就落到panda里面去。
2. Rails在某些情况下会存在API并发上的问题，对某些性能敏感的API，用go或者java去处理. 也就是某些模块一个API会有两套实现，一套是Rails的，成熟以后用go或者java再实现一遍。
3. 两套API挂不同的namespace下面，用nginx做路由转发。
4. 两套API必然会遇到用户认证的问题，前期可以两边各自实现，到后期可以考虑用kong之类的网关工具做用户认证。
5. 以后可以用这套模板代码批量做系统。
5. 短期内(1到2年)只需要集中精力在第1点就可以了。


# 设计原则
1. 多用callbacks, 方便做定制化。
## Notes
1. Rails Engine和Rails Plugin的区别.
1. 加载本地gem: `gem 'core', path: '../core'`

# Famous engine
1. Rails is the biggest engine.
1. [Thredded](https://github.com/thredded/thredded), Thredded is a Rails 4.2+ forum/messageboard engine. Its goal is to be as simple and feature rich as possible.
1. [Spree](https://github.com/spree/spree),Spree is a complete open source e-commerce solution built with Ruby on Rails.
1. [Devise](https://github.com/heartcombo/devise),Flexible authentication solution for Rails with Warden.
1.

# Famous Rails app(open sourced)
1. [Discourse](https://github.com/discourse/discourse)

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
1. ActiveAdmin routes放engine namespace下面会导致资源加载的问题，解决办法是把routes放`Rails.application.routes.draw do`下面, 具体细节查看`routes/api.rb`.
1. panda.gemspec里面添加`spec.add_development_dependency`会导致依赖项在目标项目中不会被安装。用`spec.add_dependency`则不会有这个问题。
1. 自定义migration files加载路径:
   ~~~ruby
   # ./test/test_helper.rb
   ActiveRecord::Migrator.migrations_paths = [File.expand_path("../test/dummy/db/migrate", __dir__)]`
   ~~~

   Rails Engine会根据变量`ENGINE_ROOT`自动添加migrate path:
   ~~~ruby
   #activerecord/lib/active_record/railtie.rb:42,
        task :load_config do
          if defined?(ENGINE_ROOT) && engine = Rails::Engine.find(ENGINE_ROOT)
            if engine.paths["db/migrate"].existent
              ActiveRecord::Tasks::DatabaseTasks.migrations_paths += engine.paths["db/migrate"].to_a
            end
          end
        end
   ~~~
   1. panda engine做了自动加载engine migration files的配置, 所以不需要手动`rails panda:install:migrations`:
	  ~~~ruby
      # lib/panda/engine.rb
      config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
       end
      ~~~
1. sqlite可以存jsonb, 查看yoga.user
1. 每改一行engine里面的代码，dummy的routes就会奔溃，得重启`rails s`
1. rails在debug模式下会渲染exception in html.
	1. 解决办法: 在basecontroller.rb里面加`rescue_from ActiveRecord::RecordInvalid`,
	1. 打印exception in json: `config.debug_exception_response_format = :api`
	1. https://www.wyeworks.com/blog/2016/01/12/improvements-to-error-responses-in-rails-5-api-mode/

## mount activeadmin inside engine
1. [Define a resource inside an engine](https://github.com/activeadmin/activeadmin/wiki/Define-a-resource-inside-an-engine)
1. [Example Engines](https://github.com/activeadmin/activeadmin/wiki#engines-gems)
