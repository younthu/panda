阿里云短信，测试: AliyunCloud::AliSmsService.new('测试', '15201991025', 'SMS_1918162822').invoke({ code: '1234' })


client = Aliyun::CloudSms.new('your_access_key_id', 'your_access_key_secret', 'your_sign_name')

## API
### Message send
```ruby
Aliyun::CloudSms.send_msg(mobile, template_code, template_param).


https://github.com/hongshu-corp/aliyun-cloud_sms
