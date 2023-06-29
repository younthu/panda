# Panda
[![Build](https://github.com/younthu/panda/actions/workflows/rubyonrails.yml/badge.svg)](https://github.com/younthu/panda/actions/workflows/rubyonrails.yml) 
Panda是一个业务代码聚合引擎，Rails Engine. 所有功能开箱即用。常用的用户系统，缓存和任务系统, 消息推送, 短信验证码, 管理后台, etc.


# Quick start

1. Add gems
    1. Add `gem 'panda', git: 'https://github.com/younthu/panda.git'` to Gemfile
2. `bundle install`
3. `rails g panda:install && rails g panda:initializer`
   1. `rauks g panda:install` will call 'rails panda:install:migrations'
4. `rails db:create && rails db:migrate`
5. start server: `rails s`
6. start sidekiq(optional): `sidekiq`
7. start rpush(optional): `rpush start`
8. check app info: `rails app:about`


# Setup

Api, rest api controller可以继承Panda::Api::Controller, 这个api包含了rest api登录的基本功能.

1. 安装panda文件: 'rails g panda:install'
2. 安装迁移文件:
    ~~~sh
    rails panda:install:migrations
    ~~~

# 后续步骤
1. 在`spec/rails_helper.rb`里面添加FactoryBot的初始化代码
   ~~~ruby 
   RSpec.configure do |config|
     config.include FactoryBot::Syntax::Methods
     config.swagger_dry_run = false
     FactoryBot.reload
   ~~~
1. 

# Demo
本项目包含一个dummy测试项目，可以通过docker-compose快速启动, 也可以手动在本地启动.

可以demo的基本内容:
1. 一个管理后台，带角色权限管理系统。
2. 带阿里云，支付宝，微信支付配置功能。需要系统运维权限。
3. 一个spree电商系统。
4. 一个会员系统。
5. 一个约课系统。
6. 聊天系统。
7. 人物管理系统。
8. 文档管理系统。
9. 流程管理系统。


## Docker compose快速启动

## 本地手动启动

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
    2. [x] Rest api for Avatar upload
    3. [x] Identity model
    4. [x] Profile model
    5. [x] 账户注销
    6. [] 拉黑
    7. [] 举报
    8. [ ] 会员等级 
    9. [ ] captcha
    10. [x] 新用户邀请
    11. [ ] 用户行为安全审计
        1.  [ ] 登录信息记录
        2.  [ ] 异地登录检测
        3.  [ ] 实名验证
        4.  [ ] 所有写操作记录。
        1. [ ] 禁用账户
    12. [ ] 组织结构
        1.  [ ] 小组/团队
        2.  [ ] 家庭
        3.  [ ] 公司
        4.  [ ] 安全组
    13. [ ] API token/password token, github api token like.
2. 注册
   1. 邮箱注册
   2. 手机注册
3. 图形验证码.
4. 隐私协议生成
5. 保密协议生成
6. [ ] Login with devise
    1. [x] 手机登录
    2. [x] 手机自动登录
    3. [x] 微信登录
    4. [ ] 通过关注微信公众号来绑定账号
    5. [x] 邮箱登录
    6. [x] 账号密码登录
    7. [ ] 扫码登陆
    8. [ ] 苹果登录
7. [ ] Feature Toggle
8. [ ] 致敬redmine
    1. [ ] dynamic fields
    2. [ ] Workflow of ticket status.
10. [x] 聊天
11. [ ] 站内信
12. [x] 基于Secure_token的token管理和身份认证.
   1. 目前`secure_token`和`devise`不能同时在`controller`里面用，因为有命名冲突,`current_user`和`authenticate_user!`都冲突了。目前的解决办法是通过`Panda.token_method == :secure_token`来决定是用secure_token还是`devise`
   2. 目前登录时两种token都会返回. `devise token`在`auth_token`下面, `secure_token`在`secure_token`字段
   3. 切换token认证方式需要去panda.rb里面设置token_method, 用postman测试过myinfo api, secure_token是工作的.
   1.
13. [x] Login with wechat
14. [x] User
15. [x] 后台用户权限管理
    1. [x] Roles
    2. [x] Permissions
    3. [ ] 角色配置页面, 分管理员和用户
    4. [ ] 权限配置页面, 分管理员和用
16. [x] wx_pay, WechatMiniService from Tekapic.
17. [x] config gem with settings files.
18. [ ] 常用可通用的功能写到subfolder里面以gem的形式加载.
19. [ ] swagger
20. [ ] Kaminari pagination
21. [x] Localization
22. [ ] ElasticSearch
23. [x] Redis
24. [ ] ELK Log
25. [ ] Sidekiq
26. [ ] Puma auto restart. 解决ruby内存泄漏到问题
27. [x] CORS
     1. 默认关闭CORS
        [//]: # (   2. `rails g panda:install` 会生成`config/cors/initilaizer.rb`)
26. [ ] OAuth
27. [ ] JWT
28. [ ] RPush
29. [ ] Log rotation
30. [ ] ActiveAdmin
    1. [x] 后台
31. [ ] 朋友圈
    1. [ ] 照片
    2. [ ] 文字
    3. [ ] 点赞
    4. [ ] 评论
    5. [ ] 搜索
    6. [ ] 订阅
32. [ ] Panda installer
     1. [x] 添加自动加载路径`routes/*.rb`到`config/application.rb`里面去
     2. [ ] Install UsersController subclass to target app.
     3. [ ] Install API views to vendor folder as spree does.
33. [ ] 基于数据库的配置
     1. [ ] config做基于文件的静态配置
     2. [ ] rails-settings-cached做基于数据库的动态配置管理，给运维人员用.
34. [ ] 订单系统
35. [ ] 支付系统
    1.  [ ] 微信支付
    2.  [ ] 支付宝支付
    3.  [ ] 苹果支付
36. [ ] spree商城
37. [ ] sentry rails
38. [ ] newrelic 免费版
39. [ ] devise authentication in go
40. [ ] MQTT
41. [ ] Websocket/action cable
42. [ ] Message Queue, kafka, 削峰填谷
43. [ ] APIs in go
44. [ ] nginx configuration
45. [ ] APIs in python
    1.  [ ] secure token authentication in python
    2.  [ ] password authentication in python
46. [ ] APIs in java
    1.  [ ] secure token authentication in java
    2.  [ ] password authentication in java
47. [ ] 工作流引擎
    1. [ ] 请假流程审批
    2. [ ] 设计文档审批
    3. [ ] 可以参考
48. [ ] [Rails Settings Cached]( https://github.com/huacnlee/rails-settings-cached )
49. [ ] 禁用panda的dashboard, settings里面禁用
50. [ ] 微信分享
51. [ ] 收藏
52. [ ] 点赞/Like
53. [ ] 浏览历史
54. [ ] App版本控制
56. [ ] 类似Redmine的插件系统
55. [ ] 用户运营
    1.  [ ] 用户反馈，投诉建议
    2.  [ ] 客服
    3.  [ ] 积分系统
    4.  [ ] 虚拟货币系统
    5.  [ ] 抽奖系统
    6.  [ ] 签到打卡
    7.  [ ] 邀请注册
    8.  [ ] 全局小喇叭
    9.  [ ] 押金
    10. [ ] 红包
    11. [ ] 扫码核验核销
56. [ ] 应用内广告, banner
57. [ ] 分销系统
    1.  [ ] 邀请注册
    2.  [ ] 会员等级
    3.  [ ] 
58. [ ] 会员卡系统
    1.  [ ] 等级
    2.  [ ] 金额
    3.  [ ] 门票预约
    4.  [ ] 课程预约
59. [ ] 优惠券
    1.  [ ] 无门槛现金券
    2.  [ ] 满减券
    3.  [ ] 兑换券
    4.  [ ] Spree里面有[优惠券](https://github.com/spree/spree/blob/main/core/app/models/spree/promotion_handler/coupon.rb), 可以参考一下.
60. [ ] 调试
    1. [ ] 系统探针？
    2. [ ] 远程日志?
    3. [ ] 数据库数据记录自诊断
    4. [x] 系统信息&系统配置页面, [chef/ohai](https://github.com/chef/ohai)
    1. [ ] Impersonate, switch user, 扮演其他账号做测试，调试。
61. [ ] 测试
    1. [ ] UT
    2. [ ] Postman
    3. [ ] Jmeter
62. Docker
    1. [x] Docker文件
    2. [x] Docker-compose文件
    3. [ ] Docker-compose for dummy
    4. [ ] K8S Helm Chart
63. 运维
    1. [ ] 拷贝ansible scripts from yoga
    2. [ ] 拷贝ansible scripts with panda:install
    1. [ ] 在线重启app
64. [ ] 技术文档,gitbook.
65. [ ] 用户基本的API request频率限制, 防止攻击.
66. [ ] 自定义字段
    1.  [ ] 表内固定自定义字段，省去跨表的成本，数量有限，但是性能好。
    2.  [ ] 表外自定义字段，像redmine里面的自定义字段，还有spree里面的自定义字段，无限制，但是跨表消耗大一些。
67. [ ] B2B2C后台

# Rails generators

1. [x] Docker-compose template generator
2. [ ] Panda settings generator(config rb and settings yaml)
    1. [ ] ansible scripts
    1. [x] 添加自动加载路径`routes/*.rb`到`config/application.rb`里面去
    1. [ ] Install UsersController subclass to target app.
    2. [ ] Install API views to vendor folder as spree does.
3. [ ] Seeds generator
4. [ ] Generator网页，点击直接生成目标内容的界面。
5. [x] API/rspec Generator from Gu
   1. 说明见`lib/generators/panda/readme.md`
6. [ ] 小程序generator
7. [ ] React Native app generator
8. [ ] Ant Design Admin pages Generator
9. [ ] 安全审查
   1.  [ ] 文字审查
   2.  [ ] 图片审查
10. [ ] 图片处理，用imagick + sidekiq处理。
   1.  [ ] 缩略图
   2.  [ ] 


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
2. 先直接做成单体应用，再考虑拆gem, 第三步再考虑拆服务。
3. 
## Notes
1. Rails Engine和Rails Plugin的区别.
2. 加载本地gem: `gem 'core', path: '../core'`

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
   ActiveRecord::Migrator.migrations_paths = [File.expand_path("../test/dummy/db/migrate", __dir__)]
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

## 更改json的渲染layout
继承Panda::Api:BaseController以后就会默认使用带分页功能的layout, 
 有几种办法可以避免用panda带的layout
1. 在API里面通过layout指令来指定模版: `layout 'panda/layouts/application'`, 具体参考 `Panda::Api::BaseController`.
2. 在controller里指定不使用layout: `layout false`, 具体参考 `Panda::Api::BaseController`.
3. render的时候不使用layout: `render :index, layout: false`


## mount activeadmin inside engine
1. [Define a resource inside an engine](https://github.com/activeadmin/activeadmin/wiki/Define-a-resource-inside-an-engine)
1. [Example Engines](https://github.com/activeadmin/activeadmin/wiki#engines-gems)
