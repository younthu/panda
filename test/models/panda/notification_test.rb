# == Schema Information
#
# Table name: panda_notifications
#
#  id           :integer          not null, primary key
#  body         :string
#  noti_type    :string           default("notification")
#  payload_type :string
#  read         :boolean          default(FALSE)
#  sender_type  :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  payload_id   :integer
#  receiver_id  :integer          not null
#  sender_id    :integer
#
# Indexes
#
#  index_panda_notifications_on_payload      (payload_type,payload_id)
#  index_panda_notifications_on_receiver_id  (receiver_id)
#  index_panda_notifications_on_sender       (sender_type,sender_id)
#
# Foreign Keys
#
#  receiver_id  (receiver_id => panda_users.id)
#
require "test_helper"

module Panda
  class NotificationTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
  end
end
