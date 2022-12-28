# frozen_string_literal: true

class AliyunSmsService
  attr_accessor :mobile, :template

  SIGN_NAME = Settings.sms.signature_name

  def initialize(mobile, template)
    @mobile = mobile
    @template = template
  end

  def invoke(body)
    Aliyun::CloudSms.configure do |config|
      config.access_key_id = Settings.aliyun.access_key.sms
      config.access_key_secret = Settings.aliyun.access_key_secret.sms
      config.sign_name = SIGN_NAME
    end

    res = Aliyun::CloudSms.send_msg(mobile, template, body)

    Rails.logger.debug res.body
  end
end
