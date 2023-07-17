# == Schema Information
#
# Table name: panda_report_abuses
#
#  id             :integer          not null, primary key
#  content        :string
#  images         :string
#  status         :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  target_user_id :integer          not null
#  user_id        :integer          not null
#
# Indexes
#
#  index_panda_report_abuses_on_target_user_id  (target_user_id)
#  index_panda_report_abuses_on_user_id         (user_id)
#
# Foreign Keys
#
#  target_user_id  (target_user_id => panda_users.id)
#  user_id         (user_id => panda_users.id)
#
require "test_helper"

module Panda
  class ReportAbuseTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
  end
end
