# == Schema Information
#
# Table name: panda_messages
#
#  id            :integer          not null, primary key
#  body          :string
#  msg_type      :string
#  payload_type  :string           not null
#  read          :boolean
#  receiver_type :string           not null
#  sender_type   :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  payload_id    :integer          not null
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
module Panda
  class Message < ApplicationRecord
    belongs_to :sender, polymorphic: true
    belongs_to :receiver, polymorphic: true
    belongs_to :payload, polymorphic: true
  end
end
