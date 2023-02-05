# frozen_string_literal: true

FactoryBot.define do
  factory :panda_notification, class: 'Panda::Notification' do
    read { true}
  end
end
