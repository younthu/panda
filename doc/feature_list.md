1. 短信验证码发送
2. 短信验证码登录
   1. 可以通过传递特殊验证码来绕过验证码验证，用于测试和苹果审核。
   2. 这个特殊验证码在`settings`里面设置. 任何手机都可以通过special_code来通过验证, 任何special_phones都可以跳过验证码登录.
      ~~~yaml
      sms:
        special_code: 12345678
        special_phones: [13700001111]
      ~~~
3. 