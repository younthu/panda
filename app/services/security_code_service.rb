# frozen_string_literal: true

class SecurityCodeService
  attr_accessor :mobile

  TEMPLATE = Settings.sms.template

  def initialize(mobile)
    @mobile = mobile
  end

  def invoke
    raise CustomMessageError.new(422, '电话号码必须是11位') if mobile.size != 11

    code = mobile.in?(Settings.sms.special_phones) ? '1234' : Utils::Random.digital_code(4)

    $redis.set "#{mobile}_code", code
    $redis.expire("#{mobile}_code", 1800)

    AliyunSmsService.new(mobile, TEMPLATE).invoke(code:) unless Rails.env.test?
  end

  def verify(code)
    puts "verify special code #{code} == #{Settings.sms.special_code}: #{code == Settings.sms.special_code.to_s}"
    return true if Settings.sms.special_phones.include? mobile.to_s
    return true if code.to_s == Settings.sms.special_code.to_s

    redis_code = $redis.get "#{mobile}_code"

    raise CustomMessageError.new(422, '验证码错误') if redis_code != code
  end
end
