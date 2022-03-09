module AliyunCloud
  class AliSmsService
    attr_accessor :sign_name, :telephone, :template

    def initialize(sign_name, telephone, template)
      @sign_name = sign_name
      @telephone = telephone
      @template = template
    end

    def invoke(body)
      Aliyun::CloudSms.configure do |config|
        config.access_key_id = Settings.aliyun_access_id
        config.access_key_secret = Settings.access_key_secret
        config.sign_name = sign_name
      end

      Aliyun::CloudSms.send_msg(telephone, template, body)
    rescue StandardError => e
      Rails.logger.info("短信发送失败： #{e.message}")
    end
  end
end
