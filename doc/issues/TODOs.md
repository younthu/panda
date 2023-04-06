正常使用panda必须解决的问题:
1. [ ] `initializers/redis.rb`会去读取settings里的内容，如果目标app没有`config/settings.yml`或者里面不包含redis相关的配置，整个app就没法正常启动
2. [ ] 手机验证码登录的时候抛`undefined local variable or method 'extras' for #<Panda::Api::UsersController:0x00000000034b48>`, `panda/api/users_controller.rb:27:in 'sms_login'
   `
3. [ ] settings里面缺sms.special_code设置.
4. [ ] user模型强制验证email和password，导致redmine创建匿名用户失败。