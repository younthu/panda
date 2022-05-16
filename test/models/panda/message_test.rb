# == Schema Information
#
# Table name: panda_messages
#
#  id            :integer          not null, primary key
#  body          :string
#  payload_type  :string
#  read          :boolean          default(FALSE)
#  receiver_type :string           not null
#  sender_type   :string           not null
#  type          :string           default("message")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  payload_id    :integer
#  receiver_id   :integer          not null
#  sender_id     :integer          not null
#  session_id    :string
#
# Indexes
#
#  index_panda_messages_on_payload   (payload_type,payload_id)
#  index_panda_messages_on_receiver  (receiver_type,receiver_id)
#  index_panda_messages_on_sender    (sender_type,sender_id)
#
require "test_helper"

module Panda
  class MessageTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
  end
end
