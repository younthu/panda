1. /admin_users/sign_in, 管理员后台登录界面样式全丢了。但是登录进去以后的/admin页面样式是正常的。
1. ActiveAdmin配置:
   ~~~ruby
    ActiveAdmin.routes(self)
    devise_for :admin_users,  ActiveAdmin::Devise.config.merge(class_name: "Panda::AdminUser")
   ~~~
1. 运行`rails db:seed  `没有反应，运行`rails db:seed`, 提示还有pending migration, 再运行`rails db:seed`, 可以了。灵异事件。
1. rolify生成migration文件`rails g rolify AdminRole Panda::AdminUser `在migrate的时候索引_名称太长的问题,`is too long; the limit is 64 characters`:
   1. 修改migration文件，在add_index的里面添加 `name` option, 指定索引名称. [stackoverflow](https://stackoverflow.com/questions/5443740/how-do-i-handle-too-long-index-names-in-a-ruby-on-rails-activerecord-migration)
1. `rails db:drop`时抛错: `ActiveRecord::NoEnvironmentInSchemaError:`, 因为db不存在，所以抛错了，直接跳过drop, 执行 `rails db:create`
1. Rolify的generator对engine不友好，生成的代码相比在纯app下生成的有缺失，不能正常跑，需要手动改。解决办法: 在纯app里面生成一遍，把缺失的部分从纯app那边拷贝过来。
