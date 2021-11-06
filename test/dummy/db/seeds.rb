Panda::AdminUser.create! email: 'admin@example.com', password: 'password'
Panda::User.create! email: 'test@test.com', mobile: '13712345678', password: '12345678'

# 创建角色
site_admin_role = Panda::AdminRole.create! name: "site_admin", description: "站点管理员，最高权限角色"
admin_role = Panda::AdminRole.create! name: "admin", description: "系统管理员, 管理系统所有功能。"
finance_role = Panda::AdminRole.create! name: "finance", description: "财务管理。"
