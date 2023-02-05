# == Schema Information
#
# Table name: moment_comments
#
#  id                            :bigint           not null, primary key
#  content(评论文字)             :text
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  moment_comment_id(二级评论)   :bigint
#  moment_id(评论属于哪条朋友圈) :bigint
#  user_id(谁发的评论)           :bigint
#
# Indexes
#
#  index_moment_comments_on_moment_comment_id  (moment_comment_id)
#  index_moment_comments_on_moment_id          (moment_id)
#  index_moment_comments_on_user_id            (user_id)
#
FactoryBot.define do
  factory :moment_comment do
    content { 'MyText' }
    moment
    user
  end
end
