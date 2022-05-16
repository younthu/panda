# == Schema Information
#
# Table name: panda_messages
#
#  id            :integer          not null, primary key
#  body          :string
#  msg_type      :string           default("message")
#  payload_type  :string
#  read          :boolean          default(FALSE)
#  receiver_type :string           not null
#  sender_type   :string           not null
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
module Panda
  class Message < ApplicationRecord
    belongs_to :sender, polymorphic: true
    belongs_to :receiver, polymorphic: true
    belongs_to :payload, polymorphic: true, optional: true

    scope :messages_for, ->(user){ where(sender: user).or(Message.where(receiver: user))}
    scope :in_session, ->(session_id){where session_id: session_id }
  end
end
