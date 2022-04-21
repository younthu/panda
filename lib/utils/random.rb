# frozen_string_literal: true

# 随机密码相关的工具类
module Utils
  class Random
    def self.digital_code(length = 4)
      SecureRandom.random_number(('9' * length).to_i).to_s.rjust(length, '0')
    end

    def self.hex(length = 16)
      SecureRandom.hex(length)
    end
  end
end
