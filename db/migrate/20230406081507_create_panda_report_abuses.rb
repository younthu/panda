class CreatePandaReportAbuses < ActiveRecord::Migration[7.0]
  def change
    create_table :panda_report_abuses do |t|
      t.references :user, null: false, foreign_key: {to_table: "panda_users"}, comment: "举报者"
      t.references :target_user, null: false, foreign_key: {to_table: "panda_users"}, comment: "被举报人"
      t.string :content, comment: "举报内容描述"
      t.string :images, comment: "举报图片"
      t.string :status, comment: "举报状态"

      t.timestamps
    end
  end
end
