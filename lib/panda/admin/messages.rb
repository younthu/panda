# frozen_string_literal: true

ActiveAdmin.register Panda::Message do
  index do
    column :id
    column :sender_type
    column :sender_id
    column :receiver_type
    column :receiver_id
    column :payload_type
    column :payload_id
    column :body
    column :read
    column :session_id
    column :msg_type
    column :created_at
    column :updated_at

    actions
  end
end

