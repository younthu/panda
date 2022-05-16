# frozen_string_literal: true

ActiveAdmin.register Panda::Notification do
  index do
    column :id
    column :sender_type
    column :sender_id
    column :receiver_id
    column :payload_type
    column :payload_id
    column :body
    column :read
    column :type
    column :created_at
    column :updated_at

    actions
  end
end

