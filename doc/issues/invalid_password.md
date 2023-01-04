# 描述
通过`api/v1/users/sign_in?user[password]=11111111&user[mobile]=13712345678`登录，填写正确的手机号和密码，还是无法通过密码验证。

调查发现:
1. 手动在console里面update password: '11111111', 得到的`encrypted_password`和`lib/devise/encryptor.rb`里面`password = ::BCrypt::Engine.hash_secret(password, bcrypt.salt)`得出来的值不一样。
2. 密码的生成在`lib/devise/models/database_authenticatable.rb line 65`
   ~~~ruby
   def password=(new_password)
      @password = new_password
      self.encrypted_password = password_digest(@password) if @password.present?
   end
   ~~~
   可以在console里面通过命令`$ user.password=`来获取代码地址.
3. 