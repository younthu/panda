class CreatePandaApps < ActiveRecord::Migration[6.1]
  def change
    create_table :panda_apps do |t|
      t.string :name,          comment: 'App名称'
      t.string :platform,      comment: 'App所属平台, iOS, Android'
      t.string :official_site, comment: 'App官方平台'
      t.string :support_email, comment: '技术支持者邮箱'
      t.string :support_name,  comment: '技术支持者名称'
      t.string :support_phone, comment: '技术支持者手机'
      t.string :support_wechat,comment: '技术支持者微信'
      t.date   :published_at,  comment: 'app发布时间'
      t.string :owner_name,    comment: 'app归谁所有'

      t.timestamps
    end
  end
end
