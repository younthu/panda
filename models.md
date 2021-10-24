
# Model介绍

1. User
   1. User的扩展请用migration添加额外字段: `rails g migration AddFieldsToPandaUser test`
1. Identity
   1. email和mobile这两个字段已经写入User,所以默认情况下手机登录和email登录不需要用identity模型
	1. 微信登录需要用identity模型，特别是需要多微信绑定/解绑的时候，就需要identity支持了.
1. Profile
   1. 目前看来没有多大必要, 有点多余.
1.
