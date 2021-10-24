# Authorization
1. [ActiveAdmin authorization adapter](https://activeadmin.info/13-authorization-adapter.html)
1. AA不同的namespace可以设置不同的adapter.
1. 用了cancancan
1. Panda里面的activeadmin initializer设置了`cancancan`为adapter
1. 角色管理用了[Rolify](https://github.com/RolifyCommunity/rolify).
   1. Rolify的role分global role, scoped resource role.
	  1. 配置说明: https://github.com/RolifyCommunity/rolify/wiki/Configuration
	  1. global role 直接给用户.
	   1. scoped resource role指定role的同时要指定用户
   1. resource是各种要被管理的表格。要管理某个表格，需要在模型里面加入下面的内容
	  ~~~ruby
	   class Forum < ActiveRecord::Base
	   resourcify
	   end
      ~~~
   1. role是要给予用户的角色, 要授予用户角色需要加入下面的语句:
	  ~~~ruby
	   class User < ActiveRecord::Base
	   		rolify :before_add => :before_add_method

		 	def before_add_method(role)
		 		# do something before it gets added
		 	end
	   end
      ~~~

1.

# 注意
