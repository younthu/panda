class CreatePandaAppVersions < ActiveRecord::Migration[6.1]
  def change
    create_table :panda_app_versions do |t|
      t.string :pre_version,     comment: '前一版本是多少'
      t.string :current_version, comment: '当前版本号'
      t.string :minimal_version, comment: '目前服务器API最小兼容版本'
      t.string :latest_download_url, comment: '最新版下载地址'
      t.references :app, null: false, foreign_key: true, comment: 'app'

      t.timestamps
    end
  end
end
